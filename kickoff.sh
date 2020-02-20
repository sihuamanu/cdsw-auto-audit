#!/bin/bash

echo "Begin to collect CDSW reports:"

echo "--------------The whole process will table about 2 minutes----------------"

nohup sh auto_disk_usage.sh > report.out 2>&1 &
echo "*"
sleep 50
nohup sh auto_login_logout_track.sh >> report.out 2>&1 &
sleep 5
echo "**"
nohup sh auto_project_list.sh >> report.out 2>&1 &
sleep 5
echo "***"
nohup sh auto_project_create_track.sh >> report.out 2>&1 &
sleep 5
echo "****"
nohup sh auto_project_deleted_track.sh >> report.out 2>&1 &
sleep 5
echo "*****"
nohup sh auto_session_running_track.sh >> report.out 2>&1 &
sleep 5
echo "******"
nohup sh auto_session_launch_track.sh >> report.out 2>&1 &
sleep 5
echo "*******"
nohup sh auto_session_stop_track.sh >> report.out 2>&1 &
sleep 5
echo "********"
nohup sh auto_team_account_track.sh >> report.out 2>&1 &
sleep 5
echo "*********"
nohup sh auto_collaborator_track.sh >> report.out 2>&1 &
sleep 5
echo "**********"
sed -i s/'Unable to use a TTY - input is not a terminal or the right kind of file'//g report.out
echo "--------------Finished. Please check the report.out--------------------"
