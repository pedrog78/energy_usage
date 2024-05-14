# energy_usage
Project to visualise my energy usage using Grafana, and to experiment with DevOps tools and techniques for deployment

## Current Status

Currently we have a terraform script which deploys two containers to the local host - mysql and grafana

## Steps to setup

* Deploy the containers using terraform.  From the terraform folder run `terraform apply`
* Run `docker logs MySQL_consumption` and find the generated root password.  Hint.  Its preceeded by `GENERATED ROOT PASSWORD`
* Create the `energy` database, tables and a read only user.  Run `mysql -h 127.0.0.1 -u root -p < database_setup.sql`.  Enter the password when prompted

