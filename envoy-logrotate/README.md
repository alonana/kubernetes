# Collect logs from envoy
This lists the alternative that we have to collect logs from envoy.

## 1. STDOUT
Envoy prints all of it related to STDOUT.
FileBeat is configured to watch on kubernetes events, 
and track any envoy container that is deployed.
Once an envoy container is located, its STDOUT is collected using the docker output files in the folder:
`/var/lib/docker/containers`.
The STDOUT files in this folder are automatically managed by docker/kubernetes.

## 2. Log file - DaemonSet logrotate
Envoy prints output to log files.
The log files are mapped to a `hostPath` (folder on the host).

To handle the log rotation, we use a DaemonSet of logrotate.
The logrotate also has a mapping to the same `hostPath`, and it rotate the logs using `copytruncate`.
This is since it cannot signal to a process in a different Pod.
Notice that `copytruncate` might cause some data loss.

FileBeat also has a mapping to the same `hostPath`, and collects events from the files.

Notice that we might have several enforcers on the same node, 
so we should use a unique naming for the log files, 
for example, include the host name as part of the file name.

## 3. Log file - Sidecar logrotate
Same as alternative #2, only that logrotate is a sidecar in the same pod, instead of a DaemonSet.
We use `shareProcessNamespace: true`.
This means that logrotate can signal to the envoy process, and we do not need to use `copytruncate`, 
and don't have possible data loss.
However, this means that we might have several processes of logrotate on the same pod.
  
