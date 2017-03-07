#!/bin/bash

echo ">>> Generating SSH key pair"
ssh-keygen -t rsa -C "user0001@slalom.com" -b 4096 -f id_rsa -N ""

echo ">>> Importing public key into AWS"
AWS_KEY_NAME=MyKeyPair
aws ec2 import-key-pair --key-name "$AWS_KEY_NAME" --public-key-material "$(cat id_rsa.pub)"

echo ">>> Spinning up EC2 instance"
INSTANCE_ID=`aws ec2 run-instances --image-id ami-156be775 --key-name "$AWS_KEY_NAME" --count 1 --instance-type t2.micro --security-group-ids sg-7d482705 --subnet-id subnet-ea2b1fb2 | jq -r ".Instances[0].InstanceId"`
echo ">>> EC2 instance id: $INSTANCE_ID"
echo "$INSTANCE_ID" > ec2_instance_id

echo ">>> Grabbing public ip"
while [ -z $PUBLIC_IP ]; do
    aws ec2 describe-instances | jq '.Reservations[].Instances[] | select(.InstanceId=="$INSTANCE_ID") | .NetworkInterfaces[0].Association.PublicIp'
    PUBLIC_IP=`aws ec2 describe-instances | jq '.Reservations[].Instances[] | select(.InstanceId=="$INSTANCE_ID") | .NetworkInterfaces[0].Association.PublicIp'`
    echo ">>> IP not ready. Trying again in 10"
    sleep 10
done    
echo ">>> public ip: $PUBLIC_IP"

ssh -i id_rsa -o "StrictHostKeyChecking no" ubuntu@$PUBLIC_IP "uname -a"

