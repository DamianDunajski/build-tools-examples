#!/bin/bash

cd `dirname $0`
cd ..

SERVICE_TARGET=service/target/scala-2.10

mkdir -p logs

# service
nohup java -jar ${SERVICE_TARGET}/service-assembly-1.0-SNAPSHOT.jar server ${SERVICE_TARGET}/classes/config.yaml &> logs/service.log &

# client
nohup client/target/universal/stage/bin/client &> logs/client.log &