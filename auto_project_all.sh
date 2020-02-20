#!/bin/bash

echo "**********************************
*   CDSW Project Created Report  *
**********************************"

echo "----------------------------------"

kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "select b.creator_id as \"User ID\",b.username as \"User Name\",a.name as \"Project Name\" from projects a join users b on a.creator_id=b.creator_id"

echo -e "\n"

