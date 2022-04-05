#!/bin/bash

## BOOK

export GRAPHS_HOME=/Users/tony/Projects/graphs

## BOOK - DGRAPH

export DGRAPH_HOME=${GRAPHS_HOME}/dgraph

# dgraph alpha --lru_mb 2048 --graphql_extensions false --zero localhost:5080 &
cur_dir=`pwd`
cd $DGRAPH_HOME
dgraph alpha --lru_mb 1024 --graphql_extensions=false &
# dgraph alpha --lru_mb 1024 &
dgraph zero &
cd $cur_dir

# docker-compose -f ${DGRAPH_HOME}/docker-compose.yml up -d 
# docker-compose -f ${DGRAPH_HOME}/docker-compose-v1.0.16.yml up -d 

###
