#!/bin/bash

NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "cart" "user" "shipping" "payments" "dispatch" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP=sg-034b8c610c8a714d3 

#conditions
#if mysql or mongo instance should be in t3.medium and all other items instance should be t3.micro

for i in "${NAMES[@]}"
do

if [ [ $i == "mongodb" || $i == "mysql"] ]
then
    INSTANCE_TYPE="t3.medium"
else
    INSTANCE_TYPE="t3.micro"
    
fi
    echo "Creating $i...........Instance"

    IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE  --security-group-ids $SECURITY_GROUP 
    --tag-specifications "ResourceType=Instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress')

    echo "created $i instaces: $IP_ADDRESS"

done


