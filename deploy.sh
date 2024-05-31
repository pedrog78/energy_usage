#!/bin/bash

#######################################
# Deploy and configure the environment
#
#
#
#######################################

#Set the following environment variables before running
#mysql_root_pass - this is the mysql root password
#mysql_grafana_user - grafanauser
#mysql_grafana_user_pass - grafanauser password


export mysql_root_pass=abc12345
export mysql_grafana_user=grafanauser
export mysql_grafana_user_pass=passw0rd

#need an absolute path here
export TF_VAR_grafana_datasource=/home/peter/scripts/sourcecontrolled/energy_usage/grafana



#Copy some of the variables into a form that Terraform can pass
export TF_VAR_mysql_pass=$mysql_root_pass
export TF_VAR_mysql_grafana_user=$mysql_grafana_user
export TF_VAR_mysql_grafana_user_pass=$mysql_grafana_user_pass




#deploy the containers as per the Terraform plan
echo "***Deploying the containers***"
terraform -chdir=terraform apply
echo "******************************"


#configure the mysql database
echo "***Waiting for mysql to be ready ***"
while ! docker exec MySQL_consumption mysql -uroot -p$mysql_pass -e "status" 2> /dev/null;do
	echo "waiting...."
	sleep 2
done
sleep 5




echo "***Creating the mysql database***"
mysql -h 127.0.0.1 -u root -p$mysql_root_pass < mysql/database_setup.sql
echo "******************************************"

echo "***Creating the readonly user for mysql"
mysql -h 127.0.0.1 -u root -p$mysql_root_pass energy -e "CREATE USER '$mysql_grafana_user'@'%' IDENTIFIED BY '$mysql_grafana_user_pass'"
mysql -h 127.0.0.1 -u root -p$mysql_root_pass energy -e "GRANT SELECT ON energy.* TO '$mysql_grafana_user'@'%'"
echo "******************************************"
