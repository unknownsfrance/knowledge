#!/bin/bash

chmod 777 -R /solr /tmp /log
RAILS_ENV=production rake sunspot:solr:stop
RAILS_ENV=production rake sunspot:solr:start
RAILS_ENV=production rake sunspot:reindex
