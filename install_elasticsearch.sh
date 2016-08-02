#!/usr/bin/env sh
set -ex

INSTALL_PATH=/usr/share

echo "Update CA certificates..."
update-ca-certificates

echo "Download and unpack tarball..."
wget -O - "http://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ELASTICSEARCH_VERSION/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz" | tar xfz - -C $INSTALL_PATH
ln -s $INSTALL_PATH/elasticsearch-$ELASTICSEARCH_VERSION $INSTALL_PATH/elasticsearch

echo "Add group and user 'elasticsearch'"
addgroup -g 494 elasticsearch
adduser -u 494 -D -s /bin/false -h $INSTALL_PATH/elasticsearch -G elasticsearch elasticsearch
chown -R elasticsearch:elasticsearch $INSTALL_PATH/elasticsearch

INSTALL_PATH=$INSTALL_PATH/elasticsearch

for path in $INSTALL_PATH/data $INSTALL_PATH/logs $INSTALL_PATH/config $INSTALL_PATH/config/scripts
do
  mkdir -p "$path"
  chown -R elasticsearch:elasticsearch "$path"
done
