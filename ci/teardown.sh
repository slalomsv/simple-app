#!/bin/bash

AWS_KEY_NAME=MyKeyPair
echo ">>> Deleting key pair $AWS_KEY_NAME"
aws ec2 delete-key-pair --key-name "$AWS_KEY_NAME"

INSTANCE_ID=`cat ec2_instance_id`
#echo ">>> Terminating EC2 instance $INSTANCE_ID"
aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"

