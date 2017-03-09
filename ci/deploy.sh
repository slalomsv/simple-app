#!/bin/bash

PACKAGE_NAME="simple-app.tar.bz2"
PUBLIC_IP=`cat ec2_public_ip`

echo ">>> Building deploy package $PACKAGE_NAME"
tar -cjf "../$PACKAGE_NAME" *

if [ $? != 0 ]; then
  echo "Build package failed. Exiting"
  exit 1
fi

echo ">>> Transfering package to EC2 instance"
scp "../$PACKAGE_NAME" ubuntu@$PUBLIC_IP:~
ssh ubuntu@$PUBLIC_IP 'ls -lart'


if [ $? != 0 ]; then
  echo "Transfer failed. Exiting"
  exit 1
fi

#echo ">>> Remove and recreate simple-app directory"
#ssh ubuntu@$PUBLIC_IP 'rm -rf simple-app && mkdir simple-app'

#echo ">>> Extract package contents"
#ssh ubuntu@$PUBLIC_IP 'tar -xvjf "$PACKAGE_NAME" -C simple-app'

