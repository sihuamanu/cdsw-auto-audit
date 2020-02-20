#!/bin/bash

echo "********************************
*   CDSW Projects List Report  *
********************************"

echo "----------------------------------"

kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "select a.username as \"Owner\",b.id as \"Project ID\",b.name as \"Project Name\",to_char(timezone('UTC+8', a.created_at::timestamp), 'dd-Mon-YYYY HH24:MI:SS') as \"Created Time\" from users a join projects b on a.id=b.creator_id order by a.username"

