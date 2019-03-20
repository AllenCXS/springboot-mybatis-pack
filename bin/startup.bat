title #project.artifactId#
@echo off
set JAVA_OPTS=-server -Dfile.encoding=UTF-8 -Xms512m -Xmx512m -Xmn255m -XX:-UseGCOverheadLimit -DappName=#project.artifactId# -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:ParallelGCThreads=8 -XX:+PrintGCDetails -XX:+PrintGCCause -Xloggc:./logs/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=100 -XX:GCLogFileSize=20m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./dump/ 
java %JAVA_OPTS%  -cp ".;./lib/#project.artifactId#-#project.version#.jar" #mainClass#&
pause
