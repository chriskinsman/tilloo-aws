pushd terraform
terraform init
terraform apply
popd
AWS_PROFILE=personalaws aws eks update-kubeconfig --name tilloo
echo "Add AWS_PROFILE to ~/.kube/config if you get an unauthorized error"
kubectl apply -f config_aws_auth.yaml
