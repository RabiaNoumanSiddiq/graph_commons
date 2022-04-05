#!/bin/bash

## BOOK

export GRAPHS_HOME=/Users/tony/Projects/graphs

## BOOK - GRAPHDB

# export GRAPHDB_VERSION=8.10.1
# export GRAPHDB_VERSION=9.2.0
export GRAPHDB_VERSION=9.7.0
export GRAPHDB_HOME=${GRAPHS_HOME}/graphdb/graphdb-free-${GRAPHDB_VERSION}
export PATH=${PATH}:$GRAPHDB_HOME/bin

kill -9 `cat ${GRAPHDB_HOME}/pid.txt`
graphdb -d -p ${GRAPHDB_HOME}/pid.txt

