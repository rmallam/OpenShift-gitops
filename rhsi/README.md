Install Red Hat Service interconnect using Downstream images provided by Red Hat 

The downstream images are available in the Red Hat registry "registry.redhat.com". This deployment manifest has the default images set to redhat registry. '

if you want to override them with your own container image registry.  Copy the images from Red Hat registry to your registry using skopeo copy and update the below environment variables in the manifest file.

```
        - name: QDROUTERD_IMAGE
          value: registry.redhat.io/service-interconnect/skupper-router-rhel9:2.5.1
        - name: SKUPPER_SERVICE_CONTROLLER_IMAGE
          value: registry.redhat.io/service-interconnect/skupper-service-controller-rhel9:1.5.3
        - name: SKUPPER_CONFIG_SYNC_IMAGE
          value: registry.redhat.io/service-interconnect/skupper-config-sync-rhel9:1.5.3
        - name: SKUPPER_FLOW_COLLECTOR_IMAGE
          value: registry.redhat.io/service-interconnect/skupper-flow-collector-rhel9:1.5.3
        - name: PROMETHEUS_SERVER_IMAGE
          value: registry.redhat.io/openshift4/ose-prometheus:v4.13.0
        - name: OAUTH_PROXY_IMAGE
          value: registry.redhat.io/openshift4/ose-oauth-proxy:v4.14.0

```


To deploy skupper,  run the below commands.

```
oc apply -f skupper-site.yaml
```

```
oc apply -f site-controller.yaml
```

