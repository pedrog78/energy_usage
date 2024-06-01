# energy_usage
Project to visualise my energy usage using Grafana, and to experiment with DevOps tools and techniques for deployment

## Current Status

The infrastructure consists of :
* A mysql instance with the `energy` database and a table schema for electricity bill data
* A grafana instance which has got a mysql datasource configured to connect to the `energy` database with a readonly user.

The infrastructure can be deployed with the `./deploy.sh` script 

## Prerequisites

* Terraform
  * Install from https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
* Docker CE
  * Install from https://docs.docker.com/engine/install/
* A `vars.env` file in your repo root containing variables for your install.  Example in vars.env.template

## Steps to setup and configure

* From the repository root, run the `deploy.sh` Bash script.
