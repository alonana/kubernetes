FROM envoyproxy/envoy:latest
COPY envoy.yaml /etc/envoy/envoy.yaml
COPY envoy_wrapper.sh /envoy_wrapper.sh
ENTRYPOINT /envoy_wrapper.sh
