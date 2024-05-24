#!/bin/sh

namespace=$1
if [ -z $namespace ]; then
  echo "Namespace name is required"
  exit 1
fi

if [ ! -z "$OKTETO_CA_CERT" ]; then
   echo "Custom certificate is provided"
   echo "$OKTETO_CA_CERT" > /usr/local/share/ca-certificates/okteto_ca_cert.crt
   update-ca-certificates
fi

members=$2
membersArg=""
IFS=","
for v in $members
do

   verify=$(echo $v | egrep -c "[;:!#$%^&*() ]" )
   if [ "$verify" -gt 0 ]; then
    echo "the members parameters contains invalid characters"
    exit 1
  fi
    
   membersArg="-m '$v' $membersArg"
done

log_level=$3
if [ ! -z "$log_level" ]; then
  if [ "$log_level" = "debug" ] || [ "$log_level" = "info" ] || [ "$log_level" = "warn" ] || [ "$log_level" = "error" ] ; then
    log_level="--log-level ${log_level}"
  else
    echo "log-level supported: debug, info, warn, error"
    exit 1
  fi
fi

# https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging
# https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables
if [ "${RUNNER_DEBUG}" = "1" ]; then
  log_level="--log-level debug"
fi

echo running: okteto namespace create $namespace $membersArg $log_level
eval okteto namespace create $namespace $membersArg $log_level

echo running: okteto kubeconfig
eval okteto kubeconfig