#!/bin/bash

rows=`kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT a.id as \"Project ID\",b.username as \"User Name\",a.name as \"Project Name\",a.project_visibility as \"Project Visibility\" FROM projects a join users b on a.user_id=b.id where a.project_visibility='public'" | tail -n 2 | awk '{print $1}'`

row_num=`cut -d "(" -f 2 <<< $rows`
row_num=`awk '{print $1}' <<< $row_num`
echo ${row_num}
