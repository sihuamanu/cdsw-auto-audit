#!/bin/bash

user=$1
path="/var/lib/cdsw/current/projects/projects/0/"
num=1

echo "***********************************************************
*   CDSW Admin Auto Clear the Projects Relevant to a User  *
************************************************************"

echo "----------------------------------"

res=(`kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -X -t -c "select b.id as \"Project ID\",b.name from users a join projects b on a.id=b.creator_id where a.username='${user}' order by a.username" | awk '{print $1}'`)
name=(`kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -X -t -c "select b.id as \"Project ID\",b.name from users a join projects b on a.id=b.creator_id where a.username='${user}' order by a.username" | awk '{print $3}'`)

len=${#res[@]}
lennew=`expr ${len} - ${num}`

for (( i=0; i<${lennew}; i++ ));
do
  projectpath=${path}${res[$i]}
  #echo ${projectpath}

  #find ${projectpath}
  du -h -d 0 ${projectpath}
  echo "Project Name: " ${name[$i]}
  echo "------------------------------------"
  #rm -f -r ${projectpath}
  #kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -X -t -c "delete from projects where id='${res[$i]}'"
done

echo -e "\n"
