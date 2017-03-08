# Simple App

## What is this?
This app is for demo purposes only. It consists of a frontend in node.js (v6.x) that displays data from a table from a MySQL backend.

## Usage

```
git clone https://github.com/sosimon/simple-app.git
cd simple-app
npm install
node app.js
```

Hit http://localhost:3000/

## CI

We're using TravisCI; the configuration is defined in `.travis.yml`. The following is a description of the sequence of activities.

1. Set environment variables
    - AWS access keys - AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY will probably need to change depending on the AWS account being used
2. Setup (before_install)
    - Install AWS CLI
    - EC2 - `setup.sh` will spin up a new instance and attempt to verify the SSH connection
    - RDS - MySQL instance already setup; no configuration required
3. Testing (script)
    - Lint - `lint.sh`, which runs `npm run lint`
    - Unit tests - INCOMPLETE
4. Deploy
    - Deploy app to EC2 - INCOMPLETE, but EC2 instance already has a version of the app deployed
    - Integration tests on the EC2 instance - `test.sh`, which runs `npm run test`
5. Teardown (after_script)
    - `teardown.sh`: remove SSH keypair and terminate EC2 instance
