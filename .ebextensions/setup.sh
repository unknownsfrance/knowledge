#!/usr/bin/env bash

#chmod 777 -R /solr /tmp /log
#RAILS_ENV=production rake sunspot:solr:stop
#RAILS_ENV=production rake sunspot:solr:start
#RAILS_ENV=production rake sunspot:reindex

. /opt/elasticbeanstalk/support/envvars
cd $EB_CONFIG_APP_CURRENT
su -c "RAILS_ENV=production rake sunspot:reindex" $EB_CONFIG_APP_USER
