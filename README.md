# NGINX

**NOTICE:**
Nothing will work if you have docker installed on your machine as well as k8s.
The iptables changes of docker collides with k8s.

Install 
```
kubectl apply -f ./nginx/deployment.yaml
kubectl apply -f ./nginx/service.yaml
```

Check status 
```
kubectl get deployments --selector=configid=nginx-deployment
kubectl describe deployments nginx-deployment

kubectl get pods --selector=configid=nginx-container
kubectl describe pod REPLACE_POD_NAME

kubectl get services --selector=config-id=nginx-service
kubectl describe service nginx-service
```

Connect to running container 
```
kubectl exec -it REPLACE_POD_NAME -- /bin/bash
```

Get the minikube IP
```
sudo minikube status
```

Access the NGINX app:
```
curl REPLACE_MINIKUBE_IP:30001
```