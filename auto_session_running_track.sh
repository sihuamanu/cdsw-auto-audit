#!/bin/bash

echo "**********************************
*  CDSW Session Running Report   *
**********************************"

echo "----------------------------------"

kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT a.user_id as \"User ID\",b.username as \"User Name\",c.project_id as \"Project ID\",c.id as \"Session ID\",c.name as \"Session Name\",c.memory as \"Session Memory\",c.cpu as \"Session CPU\",c.kernel as \"Session Kernel\",c.status as \"Session Status\",to_char(timezone('UTC+8', a.created_at::timestamp), 'dd-Mon-YYYY HH24:MI:SS') as \"Created Time\" FROM user_events a join users b on a.user_id=b.id join dashboards c on c.id=a.description where c.status='running' order by b.username"

echo -e "\n"

