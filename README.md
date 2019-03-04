
# Open Issues
- Persistence store for ElasticSearch - decide on a method
- Production ready configuration for ElasticSearch
- ElasticSearch service is exposed in all pods??? security issue!

# ElasticSearch
Ports:
* 9200 - queries API
* 9300 - cluster discovery


clusterIP=None --> headless service

This means that kubernetes manages endpoints and DNS, but does not supply a stable cluster IP


# Logstash
Send data to Logstash
```
curl -H "content-type: application/json" -XPUT "http://${AK8S_KUBE_IP}:30003/data" -d '{
    "timestamp" : "2009-12-29 14:12:13",
    "message" : "This is my message, please save it",
    "field1" : "more data",
    "field2" : "and some more"
}'
```

# Azure K8s Integration
- Create Azure K8s cluster
- Create Azure Container Registry
- Install Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest
- Login to Azure using CLI: `az login`
- Configure `kubectl` to use Azure K8s: 
```
az aks get-credentials --resource-group K8S_RESOUCE_GROUP --name K8S_NAME
```

## Grant K8s to access Registry
- Find K8s principal name using 
```
az ad sp list --all
```

Search fo `appId` of the K8s cluster
- Login to Azure container registry
 ```
 az acr login --name CONTAINER_REGISTRY_NAME
 ```

- Find Container Registry ID using 
```
az acr show --resource-group REGISTRY_RESOUCE_GROUP --name REGISTRY_NAME --query "id" --output tsv
```

- Grant pull permission
```
az role assignment create --assignee K8S_PRINCIPAL_NAME(section #1) --scope CONTAINER_REGISTRY_ID(section #3) --role acrpull
```

