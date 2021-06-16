#!/bin/sh
set -e

namespace=$1
if [ -z $namespace ]; then
  echo "Namespace name is required"
  exit 1
fi

share=$2
members=""
IFS=","
for v in $share
do
   members="-m $v $members"
done

echo running: okteto create namespace $namespace $members
eval okteto create namespace $namespace $members