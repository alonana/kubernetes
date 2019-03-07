FROM ubuntu:18.04
COPY envoy_rotate.sh /envoy_rotate.sh
COPY rotate.conf /rotate.conf
RUN apt-get update && \
 apt-get install -y logrotate && \
 chmod 600 /rotate.conf
ENTRYPOINT /envoy_rotate.sh
