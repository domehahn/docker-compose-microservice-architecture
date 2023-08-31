ARG ELASTIC_VERSION

# https://www.docker.elastic.co/
FROM docker.elastic.co/beats/filebeat:${ELASTIC_VERSION}
COPY filebeat.docker.yml /usr/share/filebeat/filebeat.yml
USER root
RUN chown root:filebeat /usr/share/filebeat/filebeat.yml \
    && chmod go-w /usr/share/filebeat/filebeat.yml