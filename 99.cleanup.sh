kubectl delete -f tilloo.yaml
echo "Waiting for teardown of ALB resources"
sleep 120
pushd terraform
terraform destroy
popd
aws ecr delete-repository --repository-name tilloo --profile $AWS_PROFILE --force
