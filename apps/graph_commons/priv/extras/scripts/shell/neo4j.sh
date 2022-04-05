#!/bin/bash

## BOOK

export GRAPHS_HOME=/Users/tony/Projects/graphs

## BOOK - NEO4J

# export NEO4J_VERSION=4.0.4
# export NEO4J_VERSION=3.5.7
export NEO4J_VERSION=4.2.3
export NEO4J_HOME=${GRAPHS_HOME}/neo4j/neo4j-community-${NEO4J_VERSION}
# export NEO4J_CONF=${NEO4J_HOME}/conf
export PATH=${PATH}:$NEO4J_HOME/bin

neo4j restart

