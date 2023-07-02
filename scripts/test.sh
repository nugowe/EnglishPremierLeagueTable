#!/bin/bash




if [[ ${{ github.event.client_payload.league }} == 'epl' ]]; then
    echo "app_image=nosaugowe/epltable:latest" > $GITHUB_WORKSPACE/terraform/terraform.tfvars 
    echo "Revealing the updated config...."
    cat $GITHUB_WORKSPACE/terraform/terraform.tfvars 
elif [[ ${{ github.event.client_payload.league }} == 'laliga' ]]; then
    echo "app_image=nosaugowe/laliga:latest" > $GITHUB_WORKSPACE/terraform/terraform.tfvars 
    echo "Revealing the updated config...."
    cat $GITHUB_WORKSPACE/terraform/terraform.tfvars 
fi
