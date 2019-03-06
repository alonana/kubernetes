# Open Issues
- Production ready configuration for ElasticSearch: 

dedicated master nodes

minimum_master_nodes

- Secure ElasticSearch transport protocol (port 9300) using envoy?

# Introduction
This project includes a collection mechanism for events produced by envoy deployments on a kubernetes cluster.

The envoy container produces 2 types of events:
* Access log - produced by the envoy itself
* Application events - produced by the envoy applicative filters

The events are collected using the following pipe:
Envoy -> FileBeat -> LogStash -> ElasticSearch

The following sections describe each of the pipe's steps.

## Envoy
The Envoy container is a kubernetes Pod deployment of a modified envoy docker image.
The modification includes a [script](./envoy/docker/envoy_wrapper.sh) 
that starts envoy in the background,
and prints a message to STDOUT every 10 seconds.
The message format is:
```
enforcer output <Base64 encoded JSON>
```
The JSON has the following format:
```
{
    "enforcer-version": "1", 
    "desc": "...", 
    "timestamp": "${time}", 
    "sequence": "${sequence}"
}
```
  
In addition, the [envoy configuration](./envoy/envoy.yaml) 
is configured to print access log to the STDOUT using a custom JSON formatter.
Notice that any static content can be added if required, 
for example check the `ind` column, which has static value in the JSON below.
This allows signaling of the source of the configuration related service in the access log.

```
access_log:
  - name: envoy.file_access_log
    config:
      path: "/dev/stdout"
      json_format:
        ind: "enforcer access"
        start_time: "%START_TIME%"
        req_method: "%REQ(:METHOD)%"
        req_path: "%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%"
        ...
```

The [envoy container configuration](./envoy/k8s/deployment.yaml) 
includes the kubernetes label `configid="envoy-container"`, which is later used by FileBeat.

## FileBeat
The filebeat container is deployed as a kubernetes DaemonSet (one per kubernetes node).
In the [FileBeat configuration](./filebeat/filebeat.yml) it is configured to track kubernetes events, 
and to detect any container that match the kubernetes labels: `configid="envoy-container"`. 
A service account, cluster role, and binding are applied on the kubernetes, to allow the filebeat to access kubernetes.

The filebeat is configured to collect from the envoy container STDOUT any line that includes:
`enforcer output` and `enforcer access`, hence it collects the relevant lines, and send them to logstash.

The access to logstash is:
* Secured using TLS, over port 5044, using the beats (lumberjack) protocol over tcp
* Addressed to the Logstash service name, and hence can be load balanced

## Logstash
The Logstash container is a kubernetes Pod deployment of a modified Logstash docker image.
The modification in the [Docker file](./logstash/docker/Dockerfile) 
is to install a base64 decoded plugin.

In addition, the Logstash service to enable the FileBeat agents to access it.
The Logstash service exposes 2 ports:
* 9600 - http port, currently used only for health (live/ready) tests
* 5044 - the beats protocol, used by the FileBeat

The [pipeline configuration](./logstash/pipeline.conf) is the Logstash pipeline handling configuration.
It includes the following steps:

If the message includes `enforcer output`:
* Remove FileBeat's related fields that are not used
* Remove the `enforcer output` prefix
* Base64 decode
* Deserialize the message to JSON
* Use the timestamp from the message as the ElasticSearch timestamp field
* Save to ElasticSearch index: `print-%{+YYYY.MM.dd}`

If the message includes `enforcer access`:
* Remove FileBeat's related fields that are not used
* Deserialize the message to JSON
* Use the timestamp from the message as the ElasticSearch timestamp field
* Save to ElasticSearch index: `access-%{+YYYY.MM.dd}`

## ElasticSearch
The ElasticSearch container is a kubernetes StatefulSet deployment of a modified ElasticSearch docker image.
The modified [Docker file](./elasticsearch/docker/Dockerfile) 
is required to run the `ulimit -l unlimited` before running ElasticSearch process.

The ElasticSearch is a [StatefulSet deployment](./elasticsearch/k8s/deployment.yaml), 
which means that the pods are started one after the other, 
each starting only after the previous one has completed health checks.

This is required for maintaining a persistence volume.
In minikube, this is a simple map to `hostPath`, so all containers are mapped to the same folder on the host.
In Azure, this is using `volumeClaimTemplates`.
Each instance is dynamically allocating an stable name for the persistence volume claim, 
so the claim is reused upon restart.

## Build and Deploy 
To build on minikube, run: [./build_all.sh](./build_all.sh)

To clean all on minikube, run: [./clean_all.sh](./clean_all.sh)

To run on Azure, see the section below, and the run the [./azure/build.sh](./azure/build.sh)   

Notice that each component includes the following build scripts:
* `build.sh`
* `clean.sh`
* `reinstall.sh`

The build scripts are using thge `k8s` sub folder for the k8s configuration files.

In addition, ElasticSearch data can be 
* [fetched](elasticsearch/data_fetch.sh) 
* [cleaned](elasticsearch/data_clean.sh) 

# Azure K8s Integration
- Create Azure K8s cluster
- Create Azure Container Registry
- Install Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest
- Login to Azure using CLI: `az login`
- Configure `kubectl` to use Azure K8s: 
```
az aks get-credentials --resource-group ${azureResourceGroupName} --name ${azureK8sClusterName}
```

## Grant K8s to access Registry
- Find K8s cluster principal name using 
```
az ad sp list --all
```

Search fo `appId` of the K8s cluster
- Login to Azure container registry
 ```
 az acr login --name ${azureRegistryName}
 ```

- Find Container Registry ID using 
```
az acr show --resource-group ${azureResourceGroupName} --name ${azureRegistryName} --query "id" --output tsv
```

- Grant pull permission
```
az role assignment create --assignee K8S_PRINCIPAL_NAME(section #1) --scope CONTAINER_REGISTRY_ID(section #3) --role acrpull
```

