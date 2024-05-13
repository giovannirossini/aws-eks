# AWS EKS with Kubectl GitHub Action

This GitHub Actions action allows you to deploy to AWS EKS (Elastic Kubernetes Service) using `kubectl`. It provides a convenient way to interact with your AWS EKS cluster.

## Inputs

- `aws-access-key-id` (required): The AWS access key ID.
- `aws-secret-access-key` (required): The AWS secret access key.
- `aws-region` (required): The AWS region where your EKS cluster is located.
- `cluster-name` (required): The name of your EKS cluster.
- `command` (required): The `kubectl` command to run.
- `kubectl-version` (optional): The version of `kubectl` to use. If not provided, the latest version will be used.

## Outputs

- `kubernetes`: The output of the `kubectl` command.

## Usage

```yaml
name: Deploy to AWS EKS

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Deploy to AWS EKS
        uses: giovannirossini/aws-eks@v2.0.0
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: "us-east-1"
          cluster-name: "my-eks-cluster"
          kubectl-version: "1.27"
          command: |
            kubectl apply -f stage/deployment.yaml
```

Ensure that you have set up the required AWS access credentials as secrets in your repository to securely provide them to the action.

**Note:** Make sure to replace `'us-east-1'` and `'my-eks-cluster'` with your AWS region and EKS cluster name, respectively.

For more information on AWS EKS, please refer to the [official documentation](https://aws.amazon.com/eks/).

For more information on using Kubernetes with AWS EKS, please refer to the [official Kubernetes documentation](https://kubernetes.io/docs/concepts/).

**Please Note:** It is recommended to follow AWS security best practices and manage access keys and secrets with care.
