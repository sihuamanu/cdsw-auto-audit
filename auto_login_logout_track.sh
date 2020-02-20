#!/bin/bash

echo "**************************************
* CDSW User Last Login/Logout Report *
**************************************"

echo "----------------------------------"

kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT id as \"User ID\",username as \"User Name\",to_char(timezone('UTC+8', last_login_at::timestamp), 'dd-Mon-YYYY HH24:MI:SS') as \"Last Login Time\",to_char(timezone('UTC+8', last_logout_at_tz::timestamp), 'dd-Mon-YYYY HH24:MI:SS') as \"Last Logout Time\" FROM users order by id"

echo -e "\n"



