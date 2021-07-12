#!/usr/bin/env bash

docker cp ./target/app-on-yarn-demo-1.0.0-SNAPSHOT.jar hadoop-master:/root

docker exec -it hadoop-master bash

hdfs dfs -mkdir -p /user/test/jars

hdfs dfs -put app-on-yarn-demo-1.0.0-SNAPSHOT.jar /user/test/jars

# yarn run

yarn jar app-on-yarn-demo-1.0.0-SNAPSHOT.jar com.neoremind.app.on.yarn.demo.Client \
  -jar_path /root/app-on-yarn-demo-1.0.0-SNAPSHOT.jar \
  -jar_path_in_hdfs hdfs://hadoop-master:9000/user/test/jars/app-on-yarn-demo-1.0.0-SNAPSHOT.jar \
  -appname DemoApp \
  -master_memory 1024 \
  -master_vcores 1 \
  -container_memory 1024 \
  -container_vcores 1 \
  -num_containers 3 \
  -memory_overhead 512 \
  -queue default \
  -java_opts "-XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseConcMarkSweepGC" \
  -shell_args "abc 123"
