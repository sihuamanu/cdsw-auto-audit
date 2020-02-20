#!/bin/bash

echo "************************************
*  CDSW Project Disk Usage Report  *
************************************"

overall_disk_usage=`du -h -d 0 /var/lib/cdsw/current/projects/projects/0/ | awk '{print $1}'`

echo "---------Total Usage: ${overall_disk_usage}------------------"

echo -e "\n"

for project_id in `ls /var/lib/cdsw/current/projects/projects/0/`
do
  rows=`kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -qAt -c "SELECT name FROM projects WHERE ID = $project_id"`
  rows1=`kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -qAt -c "SELECT b.name FROM projects a join users b on a.user_id=b.id WHERE a.ID = $project_id"`
  disk_usage=`du -h -d 0 /var/lib/cdsw/current/projects/projects/0/$project_id | awk '{print $1}'`
  row_count=`kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT * FROM projects WHERE ID = $project_id" | grep '0 row' | wc -l`
  if [ $row_count -gt 0 ];then
     echo "Project $project_id has been deleted"
     echo "Storage Path: /var/lib/cdsw/current/projects/projects/0/$project_id"
     echo "Disk Usage: ${disk_usage}"
     echo "----------------------------------------------------------"
  else
     echo "Project Name: ${rows}"
     echo "Owner: ${rows1}"
     echo "Disk Usage: ${disk_usage}"
     echo "Storage Path: /var/lib/cdsw/current/projects/projects/0/$project_id"
     echo "----------------------------------------------------------"
  fi
done
echo -e "\n"
