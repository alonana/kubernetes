FROM docker.elastic.co/logstash/logstash:6.6.1
COPY logstash.yml /usr/share/logstash/config/logstash.yml
RUN bin/logstash-plugin install logstash-filter-base64
