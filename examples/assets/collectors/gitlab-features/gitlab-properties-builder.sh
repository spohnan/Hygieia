#!/bin/bash

# mongo container provides the HOST/PORT
# api container provided DB Name, ID & PWD

echo "MONGODB_HOST: $MONGODB_HOST"
echo "MONGODB_PORT: $MONGODB_PORT"

PROP_FILE=hygieia-gitlab-features-collector.properties

cat > $PROP_FILE <<EOF
#Database Name
dbname=${HYGIEIA_API_ENV_SPRING_DATA_MONGODB_DATABASE:-dashboard}

#Database HostName - default is localhost
dbhost=${MONGODB_HOST:-10.0.1.1}

#Database Port - default is 27017
dbport=${MONGODB_PORT:-27017}

#Database Username - default is blank
dbusername=${HYGIEIA_API_ENV_SPRING_DATA_MONGODB_USERNAME:-db}

#Database Password - default is blank
dbpassword=${HYGIEIA_API_ENV_SPRING_DATA_MONGODB_PASSWORD:-dbpass}

#Collector schedule (required)
gitlab.cron=${GITLAB_CRON:-0 0/5 * * * *}

#Gitlab host (optional, defaults to "gitlab.com")
gitlab.host=${GITLAB_HOST:-}

#Gitlab protocol (optional, defaults to "http")
gitlab.protocol=${GITLAB_PROTOCOL:-}

#Gitlab port (optional, defaults to protocol default port)
gitlab.port=${GITLAB_PORT:-}

#Gitlab path (optional, defaults to no path)
gitlab.path=${GITLAB_PATH:-}
  
#Gitlab API Token (required, must be an admin account to retrieve all teams for the instance of gitlab.  If not admin, will only retrieve teams the user belongs to)
gitlab.apiToken=${GITLAB_API_TOKEN:-}

#Gitlab selfSignedCertificate (optional, defaults to false, set to true if your instance of gitlab is running on https without a trusted certificate
gitlab.selfSignedCertificate=${GITLAB_SELF_SIGNED_CERTIFICATE:-false}

EOF

echo "

===========================================
Properties file created `date`:  $PROP_FILE
Note: passwords hidden
===========================================
`cat $PROP_FILE |egrep -vi password`
 "

exit 0
