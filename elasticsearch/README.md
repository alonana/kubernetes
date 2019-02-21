#ElasticSearch

Ports:
* 9200 - queries API
* 9300 - internal cluster nodes communication


Version 6.2.0 is supporting kubernetes auto discovery
update your elasticsearch.yml as following
discovery.zen.ping.unicast.hosts: "kubernetes service name"

clusterIP=None --> headless service
This means that kubernetes manages endpoints and DNS, but does not supply a stable cluster IP


Install 
```
kubectl apply -f deployment.yaml
kubectl apply -f service_internal.yaml
kubectl apply -f service_exposed.yaml
```
