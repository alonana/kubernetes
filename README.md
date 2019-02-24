

#ElasticSearch

Ports:
* 9200 - queries API
* 9300 - internal cluster nodes communication


clusterIP=None --> headless service
This means that kubernetes manages endpoints and DNS, but does not supply a stable cluster IP


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


Access the app:
```
curl REPLACE_MINIKUBE_IP:REPLACE_WITH_SERVICE_PORT
```

