kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.0.0/docs/examples/rbac-role.yaml
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm install incubator/aws-alb-ingress-controller --set clusterName=tilloo --set autoDiscoverAwsRegion=true --set autoDiscoverAwsVpcID=true --name aws-alb-ingress-controller --namespace kube-system
helm install --name external-dns stable/external-dns --namespace kube-system --set rbac.create=true --set domainFilters={chriskinsman.dev} --set txtOwnerId=tilloo
