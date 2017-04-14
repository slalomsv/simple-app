#!/bin/bash
source ./ci/helpers.sh
set -e

echo ">>> Running eslint"
npm run lint