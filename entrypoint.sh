#!/bin/sh
set -e

namespace=$1
if [ -z $namespace ]; then
  echo "Namespace name is required"
  exit 1
fi

export OKTETO_HOME=$RUNNER_TEMP
mkdir -p $OKTETO_HOME
ls -la $OKTETO_HOME
echo running: okteto create namespace $namespace
okteto create namespace $namespace
