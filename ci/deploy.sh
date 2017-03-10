#!/bin/bash

source ./ci/helpers.sh

PACKAGE_NAME="simple-app.tar.bz2"
PUBLIC_IP=$(getval ci_vars PUBLIC_IP)

echo ">>> Building deploy package $PACKAGE_NAME"
tar -cjf "../$PACKAGE_NAME" * --exclude=id_rsa

if [ $? != 0 ]; then
  echo "Build package failed. Exiting"
  exit 1
fi

echo ">>> Transfering package to EC2 instance"
scp "../$PACKAGE_NAME" ubuntu@$PUBLIC_IP:~

if [ $? != 0 ]; then
  echo "Transfer failed. Exiting"
  exit 1
fi

ssh ubuntu@$PUBLIC_IP "ls -lart | grep $PACKAGE_NAME"

echo ">>> Remove and recreate simple-app directory"
ssh ubuntu@$PUBLIC_IP 'rm -rf simple-app && mkdir simple-app'

echo ">>> Extract package contents"
ssh ubuntu@$PUBLIC_IP "tar -xjf $PACKAGE_NAME -C simple-app"

