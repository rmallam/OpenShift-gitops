# OpenShift-gitops

Repo contains day2 configuration of openshift cluster using openshift gitops implementation. The initial setup of Openshift gitops is performed using github actions.
the later part of day2 config is managed by openshift-gitops.

## Pre-Requisites

  1. Openshift cluster
  2. Cluster admin access
  3. github repo
  4. bare metal nodes (ocp-virt only)
  5. git or GH Cli(optional)
## How ?

once the openshift cluster creation is completed, follow the steps below to create an openshift Service account to install openshift-gitops on the cluster.

GITHUB actions workflow will deploy the openshift-gitops CR and create an application, which will be be the bootstrap for all other apps.

### steps

create github sa for deploying argocd through github actions.
```
oc create sa gitactions -n default
oc adm policy add-cluster-role-to-user cluster-admin -z gitactions -n default
oc get secret $(oc get secret -n default | grep gitactions-token | awk -F " " '{print $1}')  -o jsonpath='{.data.token}' -n default | base64 -d
```
```
## setup gh secrets for openshift api and token
export api_url="https://api.rosa-m84tb.4vpy.p1.openshiftapps.com:6443"
echo $api_url | gh secret set OPENSHIFT_API --repo https://github.com/rmallam/OpenShift-gitops
oc get secret $(oc get secret -n default | grep gitactions-token | awk -F " " '{print $1}')  -o jsonpath='{.data.token}' -n default | base64 -d | gh secret set OPENSHIFT_TOKEN --repo https://github.com/rmallam/OpenShift-gitops
```
## ROSA

adding a baremetal machinepool for rosa to run virt workloads
```
rosa create machinepools -c ` rosa list clusters | awk -F " " '{print $2}' | grep -v NAME` --instance-type c6i.metal --name virt-pool --replicas 3
```