#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh
rm -rf target
mkdir target

echo "CA"
mkdir target/ca
openssl req \
    -x509 \
    -nodes \
    -days 3650 \
    -newkey rsa:2048 \
    -keyout target/ca/ca.key \
    -out target/ca/ca.crt \
    -subj "/C=US/ST=Acme State/L=Acme City/O=Acme Inc./CN=default.svc.cluster.local"

echo "Server"
mkdir target/server
openssl genrsa -out target/server/server_pkcs1.key 2048
openssl pkcs8 -topk8 -inform pem -in target/server/server_pkcs1.key -outform PEM -nocrypt -out target/server/server_pkcs8.key
openssl req -new \
    -key target/server/server_pkcs1.key \
    -out target/server/server.csr \
    -subj "/C=US/ST=Acme State/L=Acme City/O=Acme Inc./CN=logstash-service.default.svc.cluster.local"

echo "Client"
mkdir -p target/client
openssl genrsa -out target/client/client_pkcs1.key 2048
openssl pkcs8 -topk8 -inform pem -in target/client/client_pkcs1.key -outform PEM -nocrypt -out target/client/client_pkcs8.key
openssl req -new \
    -key target/client/client_pkcs1.key \
    -out target/client/client.csr \
    -subj "/C=US/ST=Acme State/L=Acme City/O=Acme Inc./CN=filebeat.default.svc.cluster.local"

echo "Certificates"
openssl x509 -req -days 1460 -in target/server/server.csr \
    -CA target/ca/ca.crt -CAkey target/ca/ca.key \
    -CAcreateserial -out target/server/server.crt

openssl x509 -req -days 1460 -in target/client/client.csr \
    -CA target/ca/ca.crt -CAkey target/ca/ca.key \
    -CAcreateserial -out target/client/client.crt

# Now test both the server and the client
# On one shell, run the following
# openssl s_server -CAfile target/ca/ca.crt -cert target/server/server.crt -key target/server/server.key -Verify 1
# On another shell, run the following
# openssl s_client -CAfile target/ca/ca.crt -cert target/client/client.crt -key target/client/client.key
# Once the negotiation is complete, any line you type is sent over to the other side.
# By line, I mean some text followed by a keyboard return press.

echo "Create secure beat resources"
kubectl create configmap securebeat-ca-config --from-file=target/ca/ca.crt
kubectl create secret tls securebeat-client-secret --key target/client/client_pkcs8.key --cert target/client/client.crt
kubectl create secret tls securebeat-server-secret --key target/server/server_pkcs8.key --cert target/server/server.crt

