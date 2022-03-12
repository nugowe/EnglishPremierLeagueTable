
 sudo docker pull nosaugowe/epltable:latest
 sudo docker run -d --name eplnosa2kzzzz nosaugowe/epltable:latest
 CONTAINERID=$(sudo docker ps -a | awk '{ print $1, $2 }' | grep  nosaugowe/epltable:latest | awk '{print $1 }')
 sudo docker ps -a | awk '{ print $1,$2,$7}' | grep  nosaugowe/epltable:latest > test.txt
 DockerStatus=$(cat test.txt | awk '{print$3}')
 S3_BUCKET="epltable"
 S3_SUBPATH="EPL"
 
echo $CONTAINERID
echo $DockerStatus


 


