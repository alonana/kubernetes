# Deploy
Minikube based deployment, see build.sh and clean.sh

# Open Issues
- Persistence store for ElasticSearch - decide on a method
- Production ready configuration for ElasticSearch
- ElasticSearch service is exposed in all pods??? security issue!
- Create controller in GO that push data into LogStash 
- Create client that pushes data into the controller 

# ElasticSearch

Ports:
* 9200 - queries API
* 9300 - internal cluster nodes communication


clusterIP=None --> headless service
This means that kubernetes manages endpoints and DNS, but does not supply a stable cluster IP

# FluentBit
Send to logstash:
https://docs.fluentbit.io/tutorials/ship_to/logstash

