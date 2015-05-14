#!/usr/bin/env bash

export JAVA_HOME=/usr/java/default
AGENT_DIR="${HOME}/agent"
SERVER="${SERVER_PORT_8111_TCP_ADDR##tcp://}:${SERVER_PORT_8111_TCP_PORT}"

if [ -z "$SERVER_PORT_8111_TCP_ADDR" ]; then
    echo "Fatal error: SERVER is not set."
    echo "Launch this container with --link %teamcity_server_containers_name%:SERVER"
    echo
    exit
fi

if [ ! -d "$AGENT_DIR" ]; then
    cd ${HOME}
    echo "Setting up TeamCityagent for the first time..."
    echo "Agent will be installed to ${AGENT_DIR}."
    mkdir -p $AGENT_DIR
    wget $SERVER/update/buildAgent.zip
    unzip -q -d $AGENT_DIR buildAgent.zip
    rm buildAgent.zip
    chmod +x $AGENT_DIR/bin/agent.sh
    echo "serverUrl=${SERVER}" > $AGENT_DIR/conf/buildAgent.properties
    echo "name=" >> $AGENT_DIR/conf/buildAgent.properties
    echo "workDir=../work" >> $AGENT_DIR/conf/buildAgent.properties
    echo "tempDir=../temp" >> $AGENT_DIR/conf/buildAgent.properties
    echo "systemDir=../system" >> $AGENT_DIR/conf/buildAgent.properties
else
    echo "Using agent at ${AGENT_DIR}."
fi
$AGENT_DIR/bin/agent.sh run
