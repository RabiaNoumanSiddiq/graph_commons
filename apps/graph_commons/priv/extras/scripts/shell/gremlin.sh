#!/bin/bash

## BOOK

export GRAPHS_HOME=/Users/tony/Projects/graphs

## BOOK - GREMLIN

# export GREMLIN_VERSION=3.4.6
# export GREMLIN_VERSION=3.4.2
export GREMLIN_VERSION=3.4.9
export GREMLIN_SERVER=apache-tinkerpop-gremlin-server-${GREMLIN_VERSION}
export GREMLIN_SERVER_HOME=${GRAPHS_HOME}/gremlin/${GREMLIN_SERVER}
export PATH=${PATH}:$GREMLIN_SERVER_HOME/bin

gremlin-server.sh restart

