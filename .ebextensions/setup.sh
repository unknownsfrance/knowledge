#!/bin/bash

chmod 777 -R solr/ log/ tmp/
RAILS_ENV=production rake sunspot:solr:restart
