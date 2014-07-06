#!/bin/bash

cd `dirname $0`
cd ..

SERVICE_TARGET=service/build
SERVICE_JAR=service-1.0-SNAPSHOT-uberjar

CLIENT_TARGET=client/target/universal
CLIENT_ZIP=client-1.0-SNAPSHOT

mkdir -p logs

# service
nohup java -jar ${SERVICE_TARGET}/libs/${SERVICE_JAR}.jar server ${SERVICE_TARGET}/resources/main/config.yaml &> logs/service.log &

# client
if [ ! -d ${CLIENT_TARGET}/${CLIENT_ZIP}_unzipped ]; then
	unzip -q ${CLIENT_TARGET}/${CLIENT_ZIP}.zip -d ${CLIENT_TARGET}/${CLIENT_ZIP}_unzipped
fi
nohup ${CLIENT_TARGET}/${CLIENT_ZIP}_unzipped/${CLIENT_ZIP}/bin/client &> logs/client.log &