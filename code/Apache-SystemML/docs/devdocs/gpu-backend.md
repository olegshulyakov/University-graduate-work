<!--
{% comment %}
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to you under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
{% endcomment %}
-->

# Initial prototype for GPU backend

A GPU backend implements two important abstract classes:
1. `org.apache.sysml.runtime.controlprogram.context.GPUContext`
2. `org.apache.sysml.runtime.controlprogram.context.GPUObject`

The GPUContext is responsible for GPU memory management and initialization/destruction of Cuda handles.

A GPUObject (like RDDObject and BroadcastObject) is stored in CacheableData object. It gets call-backs from SystemML's bufferpool on following methods
1. void acquireDeviceRead()
2. void acquireDenseDeviceModify(int numElemsToAllocate)
3. void acquireHostRead()
4. void acquireHostModify()
5. void release(boolean isGPUCopyModified)

## JCudaContext:
The current prototype supports Nvidia's CUDA libraries using JCuda wrapper. The implementation for the above classes can be found in:
1. `org.apache.sysml.runtime.controlprogram.context.JCudaContext`
2. `org.apache.sysml.runtime.controlprogram.context.JCudaObject`

### Setup instructions for JCudaContext:

1. Follow the instructions from `https://developer.nvidia.com/cuda-downloads` and install CUDA 7.5.
2. Follow the instructions from `https://developer.nvidia.com/cudnn` and install CuDNN v4.
3. Download install JCuda binaries version 0.7.5b and JCudnn version 0.7.5. Easiest option would be to use mavenized jcuda: 
```python
git clone https://github.com/MysterionRise/mavenized-jcuda.git
mvn -Djcuda.version=0.7.5b -Djcudnn.version=0.7.5 clean package
CURR_DIR=`pwd`
JCUDA_PATH=$CURR_DIR"/target/lib/"
JAR_PATH="."
for j in `ls $JCUDA_PATH/*.jar`
do
        JAR_PATH=$JAR_PATH":"$j
done
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JCUDA_PATH
```

Note for Windows users:
* CuDNN v4 is available to download: `http://developer.download.nvidia.com/compute/redist/cudnn/v4/cudnn-7.0-win-x64-v4.0-prod.zip`
* If above steps doesn't work for JCuda, copy the DLLs into C:\lib (or /lib) directory.

To use SystemML's GPU backend, 
1. Add JCuda's jar into the classpath.
2. Include CUDA, CuDNN and JCuda's libraries in LD_LIBRARY_PATH (or using -Djava.library.path).
3. Use `-gpu` flag.

For example: to use GPU backend in standalone mode:
```python
java -classpath $JAR_PATH:systemml-0.10.0-incubating-SNAPSHOT-standalone.jar org.apache.sysml.api.DMLScript -f MyDML.dml -gpu -exec singlenode ... 
```
