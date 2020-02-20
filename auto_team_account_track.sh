#!/bin/bash

echo "**********************************
*     CDSW Team Account Report   *
**********************************"

echo "----------------------------------"

kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT a.creator_id as \"Creator ID\",b.username as \"Creator Name\",a.username as \"Team Account Name\",to_char(timezone('UTC+8', a.created_at::timestamp), 'dd-Mon-YYYY HH24:MI:SS') as \"Time\" FROM users a join users b on a.creator_id = b.id where a.type='organization'"

echo -e "\n"

