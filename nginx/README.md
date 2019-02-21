# NGINX

Install 
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
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

