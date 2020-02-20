#!/bin/bash

echo "**********************************
* CDSW Collaborator Added Report *
**********************************"

echo "----------------------------------"

kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT a.user_id as \"User ID\",b.username as \"User Name\",a.ipaddr as \"IP\",a.event_name as \"Event Name\",a.description as \"Collaborator Name\",to_char(timezone('UTC+8', a.created_at::timestamp), 'dd-Mon-YYYY HH24:MI:SS') as \"Time\" FROM user_events a join users b on a.user_id=b.id where a.event_name='collaborator added'"

echo -e "\n"

