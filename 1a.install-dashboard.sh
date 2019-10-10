# Pin to an older version as master version had issues right after release
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/79a4490f718fcc7594e5da660491ba0e7829dc19/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml
kubectl apply -f ./eks-admin-service-account.yaml
kubectl apply -f ./eks-admin-cluster-role-binding.yaml