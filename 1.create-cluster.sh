pushd terraform
terraform init
terraform apply
popd
aws eks update-kubeconfig --name tilloo --profile $AWS_PROFILE
kubectl get nodes
echo "If a list of nodes didn't appear fix kubectl connectivity in ~/.kube/config before proceeding"