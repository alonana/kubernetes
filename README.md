# Open Issues
- Production ready configuration for ElasticSearch



[2019-03-04T11:25:27.161Z] "GET / HTTP/1.1" 200 - 0 13762 326 301 "172.17.0.1" "curl/7.58.0" "95b2222e-6977-4c99-9bd8-d5f995b9fce3" "www.google.com" "172.217.22.110:443"
[2019-03-04T11:28:19.719Z] "GET /543543 HTTP/1.1" 404 - 0 1567 166 164 "172.17.0.1" "curl/7.58.0" "3efc5964-bf1a-492f-bb02-3170841dbd2b" "www.google.com" "216.58.207.78:443"
[2019-03-04T11:28:52.604Z] "GET /q=1 HTTP/1.1" 0 DC 0 0 4687 - "172.17.0.1" "curl/7.58.0" "6a2d3506-6b13-4ea6-af01-dd466ad46f22" "www.google.com" "172.217.22.110:443"
[2019-03-04T11:29:13.780Z] "GET /search/q=1 HTTP/1.1" 0 DC 0 0 7326 - "172.17.0.1" "curl/7.58.0" "7ef64839-d517-4397-bf31-c28c6ff278bd" "www.google.com" "216.58.207.78:443"
[2019-03-04T11:29:23.719Z] "GET /search?q=1 HTTP/1.1" 403 - 0 6240 1309 1303 "172.17.0.1" "curl/7.58.0" "457b4abf-9d3a-498b-a5ba-367a5ddc254b" "www.google.com" "216.58.207.78:443"



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

