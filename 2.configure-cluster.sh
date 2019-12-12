aws eks update-kubeconfig --name tilloo --profile personal --region us-west-2
kubectl apply -f config_aws_auth.yaml
cp node-local-dns.yaml node-local-dns-temp.yaml
export CLUSTER_IP=$(kubectl get services/kube-dns -n kube-system -o jsonpath="{.spec.clusterIP}")
sed -i -e "s/__CLUSTER_IP__/${CLUSTER_IP}/g" node-local-dns-temp.yaml
kubectl apply -n kube-system -f node-local-dns-temp.yaml