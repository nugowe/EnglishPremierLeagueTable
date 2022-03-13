#!/bin/bash

set -x

echo "Running R script"

Rscript /opt/epl/EPLTable.R 

#creating s3 bucket if not inexistence
aws s3api create-bucket --bucket $S3_BUCKET --region $AWS_DEFAULT_REGION --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION || true



INDEX_BUILD (){
echo "Initializing the INDEX_BUILD Function........."
CURRENT_TIME=$(echo "$(date +'%Y-11-%d %H:%M:%S')")   
echo """
  epl-table_logs:
    version: 1
      logfile-name: s3://$S3_BUCKET/index/$EPL_FILE
        timestamp: $CURRENT_TIME

""" > index.yaml

echo "Copying initial index file...................."
#aws s3 cp index.yaml s3://$S3_BUCKET/index/index.yaml



}


PIPELINE_INDEX_ADD () {
echo "Initializing the S3_PUBLISH Function........."
CURRENT_TIME=$(echo "$(date +'%Y-11-%d %H:%M:%S')")   
aws s3 cp s3://$S3_BUCKET/index/index.yaml index.yaml
tail -n 5 index.yaml | awk "/version/{print$2}" | awk -F":" '{print $2}' > index_observe.yaml
summation=1
old_index_value=$(cat index_observe.yaml)    
sum=$(( $old_index_value + $summation ))
echo """
  epl-table_logs:
    version: $sum
      logfile-name: s3://$S3_BUCKET/index/$EPL_PNG_FILE 
        timestamp: $CURRENT_TIME

""" >> index.yaml

aws s3 cp index.yaml s3://$S3_BUCKET/index/index.yaml

}

#checking if the an index file already exists
aws s3api list-objects --bucket $S3_BUCKET --query "Contents[?contains(Key, 'index.yaml')]" > files.txt

INDEX_FILE=$(cat files.txt | awk "/Key/{print$1}" | awk -F":" '{print $2}' | awk -F"/" '{print $2}') 


if [[ $INDEX_FILE!="index.yaml" ]]; then
  INDEX_BUILD && PIPELINE_INDEX_ADD
  echo "Publishing the EPL Dashboard to s3........"
  aws s3 sync ./$EPL_PNG_FILE s3://$S3_BUCKET/ 
fi

if [[ $INDEX_FILE=="index.yaml" ]]; then
  PIPELINE_INDEX_ADD
  echo "Publishing the EPL Dashboard to s3........"
  aws s3 sync ./$EPL_PNG_FILE s3://$S3_BUCKET/ 

fi




