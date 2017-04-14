#!/bin/bash
set -e

source ./ci/helpers.sh

echo ">>> Running eslint"
npm run lint