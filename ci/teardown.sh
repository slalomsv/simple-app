#!/bin/bash

source ./helpers.sh

AWS_KEY_NAME=$(getval ci_vars AWS_KEY_NAME)
echo ">>> Deleting key pair $AWS_KEY_NAME"
aws ec2 delete-key-pair --key-name "$AWS_KEY_NAME"

INSTANCE_ID=$(getval ci_vars INSTANCE_ID)
#echo ">>> Terminating EC2 instance $INSTANCE_ID"
aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"

if [ $? == 0 ]; then
  echo "Teardown was successful"
fi