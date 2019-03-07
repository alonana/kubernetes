FROM envoyproxy/envoy:latest
COPY envoy_wrapper.sh /envoy_wrapper.sh
COPY envoy_rotate.sh /envoy_rotate.sh
COPY rotate.conf /rotate.conf
RUN apt-get update && \
 apt-get install -y logrotate && \
 chmod -R 700 /tmp && \
 chmod 600 /rotate.conf
ENTRYPOINT /envoy_wrapper.sh
