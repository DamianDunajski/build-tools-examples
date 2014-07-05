#!/bin/bash

cd `dirname $0`
cd ..

SERVICE_TARGET=service/build
CLIENT_TARGET=client/target/universal

mkdir -p logs

# service
nohup java -jar ${SERVICE_TARGET}/libs/service-1.0-SNAPSHOT.jar server ${SERVICE_TARGET}/resources/main/config.yaml &> logs/service.log &

# client
if [ ! -d ${CLIENT_TARGET}/client-1.0-SNAPSHOT_unzipped ]; then
	unzip -q ${CLIENT_TARGET}/client-1.0-SNAPSHOT.zip -d ${CLIENT_TARGET}/client-1.0-SNAPSHOT_unzipped
fi
nohup ${CLIENT_TARGET}/client-1.0-SNAPSHOT_unzipped/client-1.0-SNAPSHOT/bin/client &> logs/client.log &