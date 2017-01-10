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

package org.apache.sysml.test.integration.functions.transform;

import java.io.IOException;

import org.junit.Test;

import org.apache.sysml.api.DMLScript;
import org.apache.sysml.api.DMLScript.RUNTIME_PLATFORM;
import org.apache.sysml.runtime.DMLRuntimeException;
import org.apache.sysml.test.integration.AutomatedTestBase;
import org.apache.sysml.test.integration.TestConfiguration;
import org.apache.sysml.test.utils.TestUtils;

/**
 * 
 * 
 */
public class RunTest extends AutomatedTestBase 
{
	
	private final static String TEST_NAME1 = "Transform";
	private final static String TEST_NAME2 = "Apply";
	private final static String TEST_DIR = "functions/transform/";
	private final static String TEST_CLASS_DIR = TEST_DIR + RunTest.class.getSimpleName() + "/";
	
	private final static String HOMES_DATASET 	= "homes/homes.csv";
	//private final static String HOMES_SPEC 		= "homes/homes.tfspec.json";
	private final static String HOMES_SPEC2 	= "homes/homes.tfspec2.json";
	//private final static String HOMES_IDSPEC 	= "homes/homes.tfidspec.json";
	//private final static String HOMES_TFDATA 	= "homes/homes.transformed.csv";
	//private final static String HOMES_COLNAMES 	= "homes/homes.csv.colnames";
	
	private final static String HOMES_NAN_DATASET 	= "homes/homesNAN.csv";
	private final static String HOMES_NAN_SPEC 		= "homes/homesNAN.tfspec.json";
	//private final static String HOMES_NAN_IDSPEC 	= "homes/homesNAN.tfidspec.json";
	private final static String HOMES_NAN_COLNAMES 	= "homes/homesNAN.csv.colnames";
	
	private final static String HOMES_MISSING_DATASET 	= "homes/homesAllMissing.csv";
	private final static String HOMES_MISSING_SPEC 		= "homes/homesAllMissing.tfspec.json";
	private final static String HOMES_MISSING_IDSPEC 	= "homes/homesAllMissing.tfidspec.json";
	
	@Override
	public void setUp() 
	{
		TestUtils.clearAssertionInformation();
		addTestConfiguration(TEST_NAME1, new TestConfiguration(TEST_CLASS_DIR, TEST_NAME1,new String[]{"R"}));
	}
	
	// ---- NAN BinaryBlock ----
	
	@Test
	public void runTestWithNAN_HybridBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_NAN_DATASET, HOMES_NAN_SPEC, HOMES_NAN_COLNAMES, false, RUNTIME_PLATFORM.HYBRID, "binary");
	}

	@Test
	public void runTestWithNAN_SPHybridBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_NAN_DATASET, HOMES_NAN_SPEC, HOMES_NAN_COLNAMES, false, RUNTIME_PLATFORM.HYBRID_SPARK, "binary");
	}

	@Test
	public void runTestWithNAN_HadoopBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_NAN_DATASET, HOMES_NAN_SPEC, HOMES_NAN_COLNAMES, false, RUNTIME_PLATFORM.HADOOP, "binary");
	}

	@Test
	public void runTestWithNAN_SparkBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_NAN_DATASET, HOMES_NAN_SPEC, HOMES_NAN_COLNAMES, false, RUNTIME_PLATFORM.SPARK, "binary");
	}

	// ---- NAN CSV ----
	
	@Test
	public void runTestWithNAN_HybridCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_NAN_DATASET, HOMES_NAN_SPEC, HOMES_NAN_COLNAMES, false, RUNTIME_PLATFORM.HYBRID, "csv");
	}

	@Test
	public void runTestWithNAN_SPHybridCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_NAN_DATASET, HOMES_NAN_SPEC, HOMES_NAN_COLNAMES, false, RUNTIME_PLATFORM.HYBRID_SPARK, "csv");
	}

	@Test
	public void runTestWithNAN_HadoopCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_NAN_DATASET, HOMES_NAN_SPEC, HOMES_NAN_COLNAMES, false, RUNTIME_PLATFORM.HADOOP, "csv");
	}

	@Test
	public void runTestWithNAN_SparkCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_NAN_DATASET, HOMES_NAN_SPEC, HOMES_NAN_COLNAMES, false, RUNTIME_PLATFORM.SPARK, "csv");
	}

	// ---- Test2 BinaryBlock ----
	
	@Test
	public void runTest2_HybridBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_DATASET, HOMES_SPEC2, null, false, RUNTIME_PLATFORM.HYBRID, "binary");
	}

	@Test
	public void runTest2_SPHybridBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_DATASET, HOMES_SPEC2, null, false, RUNTIME_PLATFORM.HYBRID_SPARK, "binary");
	}

	@Test
	public void runTest2_HadoopBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_DATASET, HOMES_SPEC2, null, false, RUNTIME_PLATFORM.HADOOP, "binary");
	}

	@Test
	public void runTest2_SparkBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_DATASET, HOMES_SPEC2, null, false, RUNTIME_PLATFORM.SPARK, "binary");
	}

	// ---- Test2 CSV ----
	
	@Test
	public void runTest2_HybridCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_DATASET, HOMES_SPEC2, null, false, RUNTIME_PLATFORM.HYBRID, "csv");
	}

	@Test
	public void runTest2_SPHybridCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_DATASET, HOMES_SPEC2, null, false, RUNTIME_PLATFORM.HYBRID_SPARK, "csv");
	}

	@Test
	public void runTest2_HadoopCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_DATASET, HOMES_SPEC2, null, false, RUNTIME_PLATFORM.HADOOP, "csv");
	}

	@Test
	public void runTest2_SparkCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_DATASET, HOMES_SPEC2, null, false, RUNTIME_PLATFORM.SPARK, "csv");
	}

	// ---- HomesMissing BinaryBlock ----
	
	@Test
	public void runAllMissing_HybridBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_MISSING_DATASET, HOMES_MISSING_SPEC, null, true, RUNTIME_PLATFORM.HYBRID, "binary");
	}

	@Test
	public void runAllMissing_SPHybridBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_MISSING_DATASET, HOMES_MISSING_SPEC, null, true, RUNTIME_PLATFORM.HYBRID_SPARK, "binary");
	}

	@Test
	public void runAllMissing_HadoopBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_MISSING_DATASET, HOMES_MISSING_SPEC, null, true, RUNTIME_PLATFORM.HADOOP, "binary");
	}

	@Test
	public void runAllMissing_SparkBB() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_MISSING_DATASET, HOMES_MISSING_SPEC, null, true, RUNTIME_PLATFORM.SPARK, "binary");
	}

	// ---- HomesMissing CSV ----
	
	@Test
	public void runAllMissing_HybridCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_MISSING_DATASET, HOMES_MISSING_IDSPEC, null, true, RUNTIME_PLATFORM.HYBRID, "csv");
	}

	@Test
	public void runAllMissing_SPHybridCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_MISSING_DATASET, HOMES_MISSING_IDSPEC, null, true, RUNTIME_PLATFORM.HYBRID_SPARK, "csv");
	}

	@Test
	public void runAllMissing_HadoopCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_MISSING_DATASET, HOMES_MISSING_IDSPEC, null, true, RUNTIME_PLATFORM.HADOOP, "csv");
	}

	@Test
	public void runAllMissing_SparkCSV() throws DMLRuntimeException, IOException {
		runScalingTest( HOMES_MISSING_DATASET, HOMES_MISSING_IDSPEC, null, true, RUNTIME_PLATFORM.SPARK, "csv");
	}

	// ------------------
	
	/**
	 * 
	 * @param sparseM1
	 * @param sparseM2
	 * @param instType
	 * @throws IOException 
	 * @throws DMLRuntimeException 
	 */
	private void runScalingTest( String dataset, String spec, String colnames, boolean exception, RUNTIME_PLATFORM rt, String ofmt) throws IOException, DMLRuntimeException
	{
		RUNTIME_PLATFORM platformOld = rtplatform;
		rtplatform = rt;
	
		boolean sparkConfigOld = DMLScript.USE_LOCAL_SPARK_CONFIG;
		if( rtplatform == RUNTIME_PLATFORM.SPARK  || rtplatform == RUNTIME_PLATFORM.HYBRID_SPARK)
			DMLScript.USE_LOCAL_SPARK_CONFIG = true;

		try
		{
			getAndLoadTestConfiguration(TEST_NAME1);
			
			/* This is for running the junit test the new way, i.e., construct the arguments directly */
			String HOME = SCRIPT_DIR + TEST_DIR;
			fullDMLScriptName = null;
			
			if (colnames == null) {
				fullDMLScriptName  = HOME + TEST_NAME1 + ".dml";
				programArgs = new String[]{"-nvargs", 
											"DATA=" + HOME + "input/" + dataset,
											"TFSPEC=" + HOME + "input/" + spec,
											"TFMTD=" + output("tfmtd"),
											"TFDATA=" + output("tfout"),
											"OFMT=" + ofmt };
			}
			else {
				fullDMLScriptName  = HOME + TEST_NAME1 + "_colnames.dml";
				programArgs = new String[]{"-nvargs", 
											"DATA=" + HOME + "input/" + dataset,
											"TFSPEC=" + HOME + "input/" + spec,
											"COLNAMES=" + HOME + "input/" + colnames,
											"TFMTD=" + output("tfmtd"),
											"TFDATA=" + output("tfout"),
											"OFMT=" + ofmt };
			}
	
			boolean exceptionExpected = exception;
			runTest(true, exceptionExpected, null, -1); 
			
			fullDMLScriptName = HOME + TEST_NAME2 + ".dml";
			programArgs = new String[]{"-nvargs", 
											"DATA=" + HOME + "input/" + dataset,
											"APPLYMTD=" + output("tfmtd"),  // generated above
											"TFMTD=" + output("test_tfmtd"),
											"TFDATA=" + output("test_tfout"),
											"OFMT=" + ofmt };
	
			exceptionExpected = exception;
			runTest(true, exceptionExpected, null, -1); 
			
		}
		finally
		{
			rtplatform = platformOld;
			DMLScript.USE_LOCAL_SPARK_CONFIG = sparkConfigOld;
		}
	}	
}