/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */


package org.apache.sysml.runtime.matrix;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.hadoop.mapred.Counters.Group;
import org.apache.hadoop.mapred.JobClient;
import org.apache.hadoop.mapred.JobConf;
import org.apache.hadoop.mapred.RunningJob;
import org.apache.sysml.conf.ConfigurationManager;
import org.apache.sysml.conf.DMLConfig;
import org.apache.sysml.runtime.instructions.MRJobInstruction;
import org.apache.sysml.runtime.matrix.data.InputInfo;
import org.apache.sysml.runtime.matrix.data.OutputInfo;
import org.apache.sysml.runtime.matrix.data.TaggedMatrixIndexes;
import org.apache.sysml.runtime.matrix.data.WeightedCell;
import org.apache.sysml.runtime.matrix.mapred.GroupedAggMRCombiner;
import org.apache.sysml.runtime.matrix.mapred.GroupedAggMRMapper;
import org.apache.sysml.runtime.matrix.mapred.GroupedAggMRReducer;
import org.apache.sysml.runtime.matrix.mapred.MRConfigurationNames;
import org.apache.sysml.runtime.matrix.mapred.MRJobConfiguration;
import org.apache.sysml.runtime.matrix.mapred.MRJobConfiguration.ConvertTarget;
import org.apache.sysml.runtime.util.MapReduceTool;


public class GroupedAggMR 
{
	private static final Log LOG = LogFactory.getLog(GroupedAggMR.class.getName());
	
	private GroupedAggMR() {
		//prevent instantiation via private constructor
	}
	
	public static JobReturn runJob(MRJobInstruction inst, String[] inputs, InputInfo[] inputInfos, long[] rlens, long[] clens, 
			int[] brlens, int[] bclens, String grpAggInstructions, String simpleReduceInstructions/*only scalar or reorg instructions allowed*/, 
			int numReducers, int replication, byte[] resultIndexes,	String dimsUnknownFilePrefix, String[] outputs, OutputInfo[] outputInfos) 
	throws Exception
	{
		JobConf job = new JobConf(GroupedAggMR.class);
		job.setJobName("GroupedAgg-MR");
		
		//whether use block representation or cell representation
		//MRJobConfiguration.setMatrixValueClassForCM_N_COM(job, true);
		MRJobConfiguration.setMatrixValueClass(job, false);
	
		//added for handling recordreader instruction
		String[] realinputs=inputs;
		InputInfo[] realinputInfos=inputInfos;
		long[] realrlens=rlens;
		long[] realclens=clens;
		int[] realbrlens=brlens;
		int[] realbclens=bclens;
		byte[] realIndexes=new byte[inputs.length];
		for(byte b=0; b<realIndexes.length; b++)
			realIndexes[b]=b;
		
		//set up the input files and their format information
		MRJobConfiguration.setUpMultipleInputs(job, realIndexes, realinputs, realinputInfos, 
				realbrlens, realbclens, true, ConvertTarget.WEIGHTEDCELL);
		
		//set up the dimensions of input matrices
		MRJobConfiguration.setMatricesDimensions(job, realIndexes, realrlens, realclens);
		MRJobConfiguration.setDimsUnknownFilePrefix(job, dimsUnknownFilePrefix);
		//set up the block size
		MRJobConfiguration.setBlocksSizes(job, realIndexes, realbrlens, realbclens);
		
		//set up the grouped aggregate instructions that will happen in the combiner and reducer
		MRJobConfiguration.setGroupedAggInstructions(job, grpAggInstructions);
		
		//set up the instructions that will happen in the reducer, after the aggregation instrucions
		MRJobConfiguration.setInstructionsInReducer(job, simpleReduceInstructions);
		
		//set up the number of reducers
		MRJobConfiguration.setNumReducers(job, numReducers, numReducers);
		
		//set up the replication factor for the results
		job.setInt(MRConfigurationNames.DFS_REPLICATION, replication);
		
		//set up custom map/reduce configurations 
		DMLConfig config = ConfigurationManager.getDMLConfig();
		MRJobConfiguration.setupCustomMRConfigurations(job, config);
		
		//set up what matrices are needed to pass from the mapper to reducer
		MRJobConfiguration.setUpOutputIndexesForMapper(job, realIndexes, null, null, 
				grpAggInstructions, resultIndexes);
		
		MatrixCharacteristics[] stats=new MatrixCharacteristics[resultIndexes.length];
		for( int i=0; i < resultIndexes.length; i++ )
			stats[i] = new MatrixCharacteristics();
		
		// Print the complete instruction
		if (LOG.isTraceEnabled())
			inst.printCompleteMRJobInstruction(stats);

		byte[] resultDimsUnknown=new byte[resultIndexes.length];
		// Update resultDimsUnknown based on computed "stats"
		for ( int i=0; i < resultIndexes.length; i++ )  
			resultDimsUnknown[i] = (byte) 2;
		
		//set up the multiple output files, and their format information
		MRJobConfiguration.setUpMultipleOutputs(job, resultIndexes, resultDimsUnknown, outputs, outputInfos, false);
		
		// configure mapper and the mapper output key value pairs
		job.setMapperClass(GroupedAggMRMapper.class);
		job.setCombinerClass(GroupedAggMRCombiner.class); 
		job.setMapOutputKeyClass(TaggedMatrixIndexes.class);
		job.setMapOutputValueClass(WeightedCell.class);
		
		//configure reducer
		job.setReducerClass(GroupedAggMRReducer.class);
		
		//set unique working dir
		MRJobConfiguration.setUniqueWorkingDir(job); 
		
		//execute job
		RunningJob runjob=JobClient.runJob(job);
		
		//get important output statistics 
		Group group=runjob.getCounters().getGroup(MRJobConfiguration.NUM_NONZERO_CELLS);
		for(int i=0; i<resultIndexes.length; i++) {
			// number of non-zeros
			stats[i]=new MatrixCharacteristics();
			stats[i].setNonZeros(group.getCounter(Integer.toString(i)));
		}
		
		String dir = dimsUnknownFilePrefix + "/" + runjob.getID().toString() + "_dimsFile";
		stats = MapReduceTool.processDimsFiles(dir, stats);
		MapReduceTool.deleteFileIfExistOnHDFS(dir);
		
		return new JobReturn(stats, outputInfos, runjob.isSuccessful());
	}
	
}
