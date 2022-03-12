#!/bin/bash

docker build -t nosaugowe/epl .

CONTAINERID=$(cat /etc/hostname)

docker run -d --name epltable nosaugowe/epltable

docker cp ${CONTAINERID}:/opt/crypto/scripts/epltable.png /tmp

