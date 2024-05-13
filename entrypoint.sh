#!/usr/bin/env sh
set -e >> /dev/null 2>&1;
set -o pipefail >> /dev/null 2>&1;

ln -s /usr/bin/kubectl-v${VERSION:-1.30} /usr/bin/kubectl

echo ">>> Authenticating..."

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION

aws eks update-kubeconfig --name $CLUSTER_NAME

sh -c set -e >> /dev/null 2>&1;  set -o pipefail >> /dev/null 2>&1; $@
