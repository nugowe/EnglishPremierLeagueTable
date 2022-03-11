#!/bin/bash

set -x

INDEX_BUILD (){

CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S")    
echo """
  epl-table_logs:
    version: 1
      logfile-name: s3://$S3_BUCKET/index/$EPL_FILE
        timestamp: $CURRENT_TIME

""" > index.yaml


aws s3 cp index.yaml s3://$S3_BUCKET/index/index.yaml

aws cp s3://$S3_BUCKET/index/index.yaml index.yaml

}


INDEX_BUILD