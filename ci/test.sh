#!/bin/bash

source ./ci/helpers.sh

PUBLIC_IP=$(getval ci_vars PUBLIC_IP)

echo ">>> Starting server"
ssh ubuntu@$PUBLIC_IP 'cd ~/simple-app && pm2 start app.js'

echo ">>> Running tests"
ssh ubuntu@$PUBLIC_IP 'cd ~/simple-app && npm run test'