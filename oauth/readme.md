htpasswd -c -B -b ./users.htpasswd admin yourpasswordhere
oc create secret generic githubclientsecret --from-literal=clientSecret=yourclientsecrethere -n openshift-config
oc create secret generic htpass-secret --from-file=htpasswd=./users.htpasswd -n openshift-config
oc apply -f oauth.yaml