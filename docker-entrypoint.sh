#!/bin/sh

set -e

# Add logstash as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Run as user "logstash" if the command is "logstash"
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
  # Change the ownership of /usr/share/elasticsearch/data to elasticsearch
  chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data
	set -- su-exec elasticsearch "$@"
fi

exec "$@"
