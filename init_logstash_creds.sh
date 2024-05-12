#!/usr/bin/bash

source .env

function create_role() {
    curl -sS -k -X PUT -u "elastic:${ELASTIC_PASSWORD}" \
        -H 'Content-Type: application/json' \
        https://localhost:${ELASTIC_PORT_01}/_security/role/logstash_writer \
        -d@- <<EOF
{
  "cluster": ["manage_index_templates", "monitor", "manage_ilm"], 
  "indices": [
    {
      "names": ["logstash-*", "logs-generic-default", "mylogs-*"], 
      "privileges": ["auto_configure", "write", "create", "create_index", "manage", "manage_ilm"]  
    }
  ]
}
EOF
}

function create_user() {
    curl -sS -k -X PUT -u "elastic:${ELASTIC_PASSWORD}" \
        -H 'Content-Type: application/json' \
        https://localhost:${ELASTIC_PORT_01}/_security/user/logstash_internal \
        -d@- <<EOF
{
  "password" : "lopass",
  "roles" : ["logstash_writer"],
  "full_name" : "Internal Logstash User"
}
EOF
}

# Entry point

create_role && echo
create_user && echo
