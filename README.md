# OpenShift-gitops

create github sa for deploying argocd through github actions.
```
oc create sa gitactions -n default
oc adm policy add-cluster-role-to-user cluster-admin -z gitactions -n default

oc get secret $(oc get secret -n default | grep gitactions-token | awk -F " " '{print $1}')  -o jsonpath='{.data.token}' -n default | base64 -d

## setup gh secrets for openshift api and token
export api_url="https://api.rosa-m84tb.4vpy.p1.openshiftapps.com:6443"
echo $api_url | gh secret set OPENSHIFT_API --repo https://github.com/rmallam/OpenShift-gitops
oc get secret $(oc get secret -n default | grep gitactions-token | awk -F " " '{print $1}')  -o jsonpath='{.data.token}' -n default | base64 -d | gh secret set OPENSHIFT_TOKEN --repo https://github.com/rmallam/OpenShift-gitops

## ROSA

adding a baremetal machinepool for rosa to run virt workloads

rosa create machinepools -c ` rosa list clusters | awk -F " " '{print $2}' | grep -v NAME` --instance-type c6i.metal --name virt-pool --replicas 3