#!/usr/bin/bash




#if [[ -f $GITHUB_WORKSPACE/terraform/terraform.tfvars ]]; then
    #continue
#else
    #echo "Both variables.tf && terraform.tfvars files are missing!"


if [[ $(echo ${{ github.event.client_payload.league }}) == 'epl' ]] ; then
    #echo "app_image=nosaugowe/epltable:latest" > $GITHUB_WORKSPACE/terraform/terraform.tfvars 
    #echo "Revealing the updated config...."
    #cat $GITHUB_WORKSPACE/terraform/terraform.tfvars 
    echo "epl payload detected!"
elif [[ $(echo ${{ github.event.client_payload.league }})  == 'laliga' ]] ; then
    #echo "app_image=nosaugowe/laliga:latest" > $GITHUB_WORKSPACE/terraform/terraform.tfvars 
    #echo "Revealing the updated config...."
    #cat $GITHUB_WORKSPACE/terraform/terraform.tfvars 
    echo "laliga payload detected!"
else
    echo "No payload variable found!"
fi
