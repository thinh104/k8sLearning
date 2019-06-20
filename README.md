|ClusterIP                                            |  NodePort:
|-----------------------------------------------------|----------------------------------------------------------------------------------------
|Exposes a set of pods to other objects in the cluster|  expose a set of pods to the outside world                                             
|ports:                                               |  ports:
|  - port: 3000                                       |  - port: 3050        # other pod/container in k8 can connect to to talk to this pod
|    targetPort: 3000                                 |    targetPort: 3000  # container port want to open to the outside of this pod
|                                                     |    nodePort: 31515   # Access from the outside k8 ( not in ClusterIP)


# to run: kubectl aplly -f k8s 

can merge k8 config file to one by seperating with "---"(not recommended)

# Volumes in k8s:
- kubernetes volumes (or volumes): tied to the same pod
- persistent volumes: storage not tied to any pod. have 2 type: statically provisioned persistent volume(created), dynamically provisioned persistent volume(create on the fly)
- Persistent volumes claims (PVC): like advertisement of persistent volumes. 

# Access mode in PVC: 
- ReadWriteOnce: used by single node
- ReadOnlyMany: multiple nodes can read from this
- ReadWriteMany: Can be read and written to by many nodes

# Secrets (ex: password): 
- `kubectl create secret \<type of secret> \<secret-name> --from-literal \<key>=\<value>`
  + type of secret:(docker-registry, tls, generic)
- ex: `kubectl create secret generic pgpassword --from-literal PGPASSWORD=123456`

# Load balancer on provide road to 1 service in k8s -> not use

# to run nginx-ingress: 
- kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml

# Run on GCK:
- create postgres password screct by connect to gke CLI
- install helm using script
- before run "helm init", run following cmd to create service account for tiller:
  + `kubectl create serviceaccount --namespace kube-system tiller`
  + `kubectl create clusterolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller`
- init helm: `helm init --service-account tiller --upgrade`
- install nginx-ingress: `helm install stable/nginx-ingress --name my-nginx --set rbac.create=true`


* RBAC (Role based access control) :
- user account: a person account
- service account: identifies a pod administering a cluster
- ClusterRoleBinding: authorize an account to do a certain set of actions across the entire cluuster ( bind to an user acc or service acc)
- RoleBinding: authorize an account to do a certain set of actions in a single namespace