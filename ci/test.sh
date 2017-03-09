#!/bin/bash

PUBLIC_IP=`cat ec2_public_ip`

echo ">>> Starting server"
ssh ubuntu@$PUBLIC_IP 'cd ~/simple-app && pm2 start app.js'

echo ">>> Running tests"
ssh ubuntu@$PUBLIC_IP 'cd ~/simple-app && npm run test'