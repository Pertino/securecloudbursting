#!/bin/bash

Log() {
    /usr/bin/logger -t "$prog[$$]" -p user.notice "$*"
}

# Place to store your builds
BUILDS_HOME=/home/jenkins

# Hostname of your Jenkins master
buildhost="http://172.17.0.68:8080"

# Custom Labels to apply
labels="labels=StandardSlave"

# Hostname of this slave
hostname=${HOSTNAME}

# Slave runtime details
SLAVE_DIR=${BUILDS_HOME}/slave
SLAVE_TOOLS=${BUILDS_HOME}/tools
SLAVE_JAR=${buildhost}/jnlpJars/slave.jar

# Master Connector application (note: downloaded from Jenkins Master)
JNLP_URL="${buildhost}/computer/slave-$(hostname)/slave-agent.jnlp"

# Get the latest slave application from the Master
refresh_slave_jar() {
	mkdir -p "${SLAVE_DIR}"
	mkdir -p "${SLAVE_TOOLS}"
    pushd ${SLAVE_TOOLS}
    curl -O ${SLAVE_JAR}
    popd
}

# Run the slave
launch_slave() {
    pkill -f slave.jar
    rotate_logs
    java -jar ${SLAVE_TOOLS}/slave.jar -jnlpUrl ${JNLP_URL}
    echo Slave started as process $$
}

# Get the necessary application and run the slave
main() {
    [[ -d ${BUILDS_HOME}/slave ]] && mkdir -p ${BUILDS_HOME}/slave
    refresh_slave_jar
    launch_slave
}

main
