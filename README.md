# tilloo-aws

This repository provides samples to:

1. Use terraform to deploy a complete production ready k8s cluster to AWS.
2. Deploy the tilloo job scheduler engine into that k8s cluster

## Getting Started
You will need to:

1. Create an AWS CLI profile called "personal" which is used in all the scripts
2. Modify the last line of 3.load-balancer.sh to include the domain for which external-dns should create route53 entries.
3. Modify tilloo.yaml to include the FQDN you want tilloo deployed at and the path to your ECR repository


Steps are intended to be run in numerical order.

If you only want to create a k8s cluster you can stop after 1.create-cluster.sh.

## Dashboard
1a.install-dashboard.sh is an optional step to install the k8s dashboard.  You can launch it with ./100.start-dashboard.sh which will echo the auth token to use before starting the kubectl proxy to access the dashboard.

## Cleanup
99.cleanup.sh cleans up the resources that have been created and shuts down the cluster.
