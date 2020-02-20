#!/bin/bash

echo "**********************************
*  CDSW Session Launched Report  *
**********************************"

echo "----------------------------------"

kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT a.user_id as \"User ID\",b.username as \"User Name\",a.ipaddr as \"IP\",c.project_id as \"Project ID\",c.id as \"Session ID\",c.name as \"Session Name\",c.memory as \"Session Memory\",c.cpu as \"Session CPU\",c.kernel as \"Session Kernel\",c.shared_view_visibility as \"Visibility\",a.event_name as \"Event Name\",to_char(timezone('UTC+8', a.created_at::timestamp), 'dd-Mon-YYYY HH24:MI:SS') as \"Time\" FROM user_events a join users b on a.user_id=b.id join dashboards c on c.id=a.description where a.event_name='console launched' order by a.created_at desc"

echo -e "\n"

