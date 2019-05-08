pushd terraform
terraform init
terraform apply
popd
aws eks update-kubeconfig --name tilloo --profile $AWS_PROFILE
kubectl apply -f config_aws_auth.yaml
