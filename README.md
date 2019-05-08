# tilloo-aws
==========

This repository provides samples to:

# Use terraform to deploy a complete production ready k8s cluster to AWS.
# Deploy the tilloo job scheduler engine into that k8s cluster

## Getting Started
You will need to:

# Set AWS_ID environment variable to your AWS account id
# Set AWS_REGION environment variable to a valid AWS region i.e. us-west-2
# Set AWS_PROFILE to the AWS cli profile to use
# Change region and profile in terraform/main.tf
# Modify the last line of 3.load-balancer.sh to include the domain for which external-dns should create route53 entries.
# Modify tilloo.yaml to include the FQDN you want tilloo deployed at

Steps are intended to be run in numerical order.

If you only want to create a k8s cluster you can stop after 1.create-cluster.sh.

## Dashboard
1a.install-dashboard.sh is an optional step to install the k8s dashboard.  You can launch it with ./100.start-dashboard.sh which will echo the auth token to use before starting the kubectl proxy to access the dashboard.

## Cleanup
99.cleanup.sh cleans up the resources that have been created and shuts down the cluster.
