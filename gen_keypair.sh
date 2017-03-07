#!/bin/bash

echo ">>> Generating SSH key pair"
ssh-keygen -t rsa -C "user0001@slalom.com" -b 4096 -f id_rsa -N ""

echo ">>> Upload public key to AWS"
aws iam upload-ssh-public-key --user-name User0001 --ssh-public-key-body "$(cat id_rsa.pub)"