ClusterIP                                                 vs    NodePort:
Exposes a set of pods to other objects in the cluster           expose a set of pods to the outside world

ports:                                                              ports:
  - port: 3000                                                       - port: 3050        # other pod/container in k8 can connect to to talk to this pod
    targetPort: 3000                                                   targetPort: 3000  # container port want to open to the outside of this pod
                                                                       nodePort: 31515   # Access from the outside k8 ( not in ClusterIP)


* run: kubectl aplly -f k8s 

can merge k8 config file to one by seperating with "---"(not recommended)

*Volumes in k8s:
- kubernetes volumes (or volumes): tied to the same pod
- persistent volumes: storage not tied to any pod. have 2 type: statically provisioned persistent volume(created), dynamically provisioned persistent volume(create on the fly)
- Persistent volumes claims (PVC): like advertisement of persistent volumes. 

*Access mode in PVC: 
- ReadWriteOnce: used by single node
- ReadOnlyMany: multiple nodes can read from this
- ReadWriteMany: Can be read and written to by many nodes

*Secrets (ex: password): kubectl create secret generic <secret-name> --from-literal <key>=<value>
                                                           |
                                                     type of secret
                                            (docker-registry, tls, generic)
                     ex: kubectl create secret generic pgpassword --from-literal PGPASSWORD=123456

*Load balancer on provide road to 1 service in k8s -> not use

* to run nginx-ingress: kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
