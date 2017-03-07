#!/bin/bash

PUBLIC_IP=`cat ec2_public_ip`

echo ">>> Starting server"
ssh -i id_rsa ubuntu@$PUBLIC_IP 'cd ~/simple-app && pm2 start app.js'

echo ">>> Running tests"
ssh -i id_rsa ubuntu@$PUBLIC_IP 'cd ~/simple-app && npm run test'