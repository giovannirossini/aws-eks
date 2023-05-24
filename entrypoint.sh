#!/usr/bin/env sh
set -e >> /dev/null 2>&1;
set -o pipefail >> /dev/null 2>&1;

if [[ $1 == "kubectl" || $1 == "aws" && $2 == "eks" ]]; then
  echo "> Authenticating..."
  aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
  aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
  aws configure set default.region $AWS_DEFAULT_REGION
  aws eks update-kubeconfig --name $CLUSTER_NAME >> /dev/null
  echo "> Running: $@"
  $@
else
  echo "aws-eks: You must provide a 'kubectl' or an 'aws eks' command."
fi