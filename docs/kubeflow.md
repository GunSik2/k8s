# Kubeflow


## Install
```
# env/platform-agnostic-pns hasn't been publically released, so you will install it from master
export PIPELINE_VERSION=1.6.0
kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
kubectl wait --for condition=established --timeout=60s crd/applications.app.k8s.io
kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/env/platform-agnostic-pns?ref=$PIPELINE_VERSION"
```

## Check
- run (Optionally, you can manually add load balancing in RKE) 
```
kubectl port-forward -n kubeflow svc/ml-pipeline-ui 8080:80
```
- open the Kubeflow Pipelines UI at http://{YOUR_VM_IP_ADDRESS}:8080/


## Uninstall
```
export PIPELINE_VERSION=1.6.0
kubectl delete -k "github.com/kubeflow/pipelines/manifests/kustomize/env/platform-agnostic-pns?ref=$PIPELINE_VERSION"
kubectl delete -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
```

## Reference
- https://www.kubeflow.org/docs/components/pipelines/installation/localcluster-deployment/
