sudo docker pull nosaugowe/epltable:latest
sudo docker run -d --name epltableze nosaugowe/epltable:latest
CONTAINERID=$(sudo docker ps -a | awk '{ print $1, $2 }' | grep  nosaugowe/epltable:latest | awk '{print $1 }')
sudo docker ps -a | awk '{ print $1,$2,$7}' | grep  nosaugowe/epltable:latest > test.txt
DockerStatus=$(cat test.txt | awk '{print$3}')
S3_BUCKET="epltable"
S3_SUBPATH="EPL"
echo "printing Container ID"
echo $CONTAINERID
echo "DockerStatus"
echo $DockerStatus
        
        
if [[ $DockerStatus=="Exited" ]]; then
    sudo docker start $CONTAINERID
    sudo docker cp $CONTAINERID:/opt/epl/EPLTable.png /tmp
    echo "Listing tmp folder"
    ls /tmp
else
    echo "Runing the ImageTransfer...."
    sudo docker cp $CONTAINERID:/opt/epl/EPLTable.png /tmp
    echo "Listing tmp folder"
    ls /tmp
fi