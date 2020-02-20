#!/bin/bash

echo "**********************************
*   CDSW Project Created Report  *
**********************************"

echo "----------------------------------"

kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT a.user_id as \"User ID\",b.username as \"User Name\",a.ipaddr as \"IP\",c.id as \"Project ID\",c.name as \"Project Name\",to_char(timezone('UTC+8', a.created_at::timestamp), 'dd-Mon-YYYY HH24:MI:SS') as \"Created Time\" FROM user_events a join users b on a.user_id=b.id join projects c on c.id=a.description::int where a.event_name='project created' order by a.created_at desc"

echo -e "\n"

