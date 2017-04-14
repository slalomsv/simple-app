#!/bin/bash

source ./ci/helpers.sh

echo ">>> Generating SSH key pair"
ssh-keygen -t rsa -C "user0001@slalom.com" -b 4096 -f id_rsa -N ""

echo ">>> Importing key pair into AWS"
AWS_KEY_NAME=keypair_$(randomstr)
echo "AWS_KEY_NAME=$AWS_KEY_NAME" >> ci_vars
aws ec2 import-key-pair --key-name "$AWS_KEY_NAME" --public-key-material "$(cat id_rsa.pub)"

echo ">>> Spinning up EC2 instance"
INSTANCE_ID=`aws ec2 run-instances --image-id ami-156be775 --key-name "$AWS_KEY_NAME" --count 1 --instance-type t2.micro --security-group-ids sg-7d482705 --subnet-id subnet-ea2b1fb2 | jq -r ".Instances[0].InstanceId"`
echo "EC2 instance id: $INSTANCE_ID"
echo "INSTANCE_ID=$INSTANCE_ID" >> ci_vars

echo ">>> Grabbing public ip"
PUBLIC_IP=`aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.InstanceId==\"$INSTANCE_ID\") | .PublicIpAddress"`
set +e
while [ -z $PUBLIC_IP ]; do
  echo ">>> Public IP not associated yet. Trying again in 10s"
  sleep 10
  PUBLIC_IP=`aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.InstanceId==\"$INSTANCE_ID\") | .PublicIpAddress"`
done
set -e
echo "Public IP: $PUBLIC_IP"
echo "PUBLIC_IP=$PUBLIC_IP" >> ci_vars

echo ">>> Create SSH config file"
cat <<EOF > ~/.ssh/config
Host $PUBLIC_IP
  IdentityFile id_rsa
  StrictHostKeyChecking no
EOF
cat ~/.ssh/config

echo ">>> Waiting 30 seconds for instance to spin up"
sleep 30

# Warning: this will wait forever until the instance is in a "running" state
STATUS=`aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.InstanceId==\"$INSTANCE_ID\") | .State.Name"`
while [ $STATUS != "running" ]; do
  echo ">>> Instance state: $STATUS"
  sleep 10
  STATUS=`aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.InstanceId==\"$INSTANCE_ID\") | .State.Name"`
done
echo ">>> Instance state: $STATUS"

# Warning: this will retry the SSH connection forever until success
echo ">>> Attempting to SSH into the instance"
COUNT=0
set -e
while true; do
  (( COUNT=COUNT+1 ))
  ssh ubuntu@$PUBLIC_IP 'exit'
  if [ $? == 0 ]; then
    break
  else
    echo "Attempt $COUNT: Failed"
  fi
  sleep 10
done
echo "Attempt $COUNT: Successful"
set +e
