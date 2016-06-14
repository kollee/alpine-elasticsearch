FROM kollee/alpine-java:jre-8

RUN apk add --no-cache su-exec

ENV ELASTICSEARCH_MAJOR 2.3
ENV ELASTICSEARCH_VERSION 2.3.3

COPY install_elasticsearch.sh /
RUN /install_elasticsearch.sh

WORKDIR /usr/share/elasticsearch

ENV PATH /usr/share/elasticsearch/bin:$PATH

COPY config ./config

VOLUME /usr/share/elasticsearch/data

COPY docker-entrypoint.sh /

EXPOSE 9200 9300

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
