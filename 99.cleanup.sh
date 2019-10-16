kubectl delete -f tilloo.yaml
echo "Waiting for teardown of ALB resources"
sleep 120
pushd terraform
terraform destroy
popd
