# tilloo-aws

This repository provides samples to:

1. Use terraform to deploy a complete production ready k8s cluster to AWS.
2. Deploy the tilloo job scheduler engine into that k8s cluster

## Getting Started
You will need to:

1. Set AWS_ID environment variable to your AWS account id
2. Set AWS_REGION environment variable to a valid AWS region i.e. us-west-2
3. Set AWS_PROFILE to the AWS cli profile to use
4. Change region and profile in terraform/main.tf
5. Modify the last line of 3.load-balancer.sh to include the domain for which external-dns should create route53 entries.
6. Modify tilloo.yaml to include the FQDN you want tilloo deployed at and the path to your ECR repository


Steps are intended to be run in numerical order.

If you only want to create a k8s cluster you can stop after 1.create-cluster.sh.

## Dashboard
1a.install-dashboard.sh is an optional step to install the k8s dashboard.  You can launch it with ./100.start-dashboard.sh which will echo the auth token to use before starting the kubectl proxy to access the dashboard.

## Cleanup
99.cleanup.sh cleans up the resources that have been created and shuts down the cluster.
