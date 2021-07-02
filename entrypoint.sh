#!/bin/sh

namespace=$1
if [ -z $namespace ]; then
  echo "Namespace name is required"
  exit 1
fi

if [[ ! -z "$CUSTOM_CERTIFICATE" ]]; then
  echo "Custom certificate is provided"
  echo "$CUSTOM_CERTIFICATE" > /usr/local/share/ca-certificates/custom_certificate_crt
  update-ca-certificates
fi

members=$2
membersArg=""
IFS=","
for v in $members
do

   verify=$(echo $v | egrep -c "[;:!#$%^&*() ]" )
   if [[ "$verify" -gt 0 ]]; then
    echo "the members parameters contains invalid characters"
    exit 1
  fi
    
   membersArg="-m '$v' $membersArg"
done

echo running: okteto create namespace $namespace $membersArg
eval okteto create namespace $namespace $membersArg
