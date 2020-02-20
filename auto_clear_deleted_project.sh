#!/bin/bash

echo "************************************
*  CDSW Clear the Deleted Project  *
************************************"
echo "----------------------------------"
for project_id in `ls /var/lib/cdsw/current/projects/projects/0/`
do
  row_count=`kubectl exec $(kubectl get pods -l role=db -o jsonpath='{.items[*].metadata.name}') -ti -- psql -U sense -c "SELECT * FROM projects WHERE ID = $project_id" | grep '0 row' | wc -l`
  disk_usage=`du -h -d 0 /var/lib/cdsw/current/projects/projects/0/$project_id | awk '{print $1}'`
  if [ $row_count -gt 0 ];then
     echo "Project $project_id has been deleted"
     echo "Storage Path: /var/lib/cdsw/current/projects/projects/0/$project_id"
     echo "Disk Usage: ${disk_usage}"
#     rm -r /var/lib/cdsw/current/projects/projects/0/$project_id
     echo "----------------------------------------------------------"
  fi
done
echo -e "\n"
