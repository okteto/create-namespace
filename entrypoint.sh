#!/bin/sh
set -e

namespace=$1
if [ -z $namespace ]; then
  echo "Namespace name is required"
  exit 1
fi

members=$2
membersArg=""
IFS=","
for v in $members
do
   membersArg="-m $v $membersArg"
done

echo running: okteto create namespace $namespace $membersArg
eval okteto create namespace $namespace $membersArg