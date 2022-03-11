#!/bin/bash

docker build -t nosaugowe/epl .

echo "pwd"

pwd

echo "listing file setup"

ls

echo "accesskey"

echo $AWS_ACCESS_KEY_ID