# minikube

**NOTICE:**
Nothing will work if you have docker installed on your machine as well as k8s.
The iptables changes of docker collides with k8s.

Connect to running container 
```
kubectl exec -it REPLACE_POD_NAME -- /bin/bash
```

Get the minikube IP
```
sudo minikube status
```

Access the app:
```
curl REPLACE_MINIKUBE_IP:REPLACE_WITH_SERVICE_PORT
```