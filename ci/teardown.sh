#!/bin/bash

echo ">>> Deleting key pair"
aws ec2 delete-key-pair --key-name "$AWS_KEY_NAME"

INSTANCE_ID=`cat ec2_instance_id`
echo ">>> EC2 instance id: $INSTANCE_ID"

