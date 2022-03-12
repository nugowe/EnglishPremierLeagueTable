#!/bin/bash

docker build -t nosaugowe/epl .

CONTAINERID=$(cat /etc/hostname)

docker run -d --name epltable nosaugowe/epl

docker cp ${CONTAINERID}:/opt/epl/EPLTable.png /tmp

