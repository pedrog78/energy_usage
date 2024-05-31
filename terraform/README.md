# Terraform Config

The main.tf file defines our docker environment.  It consists of the following sections

* Provider configuration telling us to use the Docker provider
* Input variables - these are variables that we can customize at runtime
   * `mysql_pass` - The initial root password for mysql
   * `mysql_grafana_user` - The name of the user we will use as a read only mysql user in the datasource definition
   * `mysql_grafana_user_pass` - The password of the read only mysql user
   * `grafana_datasource` - The absolute (this is important) path to the location on the host where the datasource definition is stored.  This will be bind mounted to a path on the container
* Resources
   * Images - the base images to pull from DockerHub for MySQL and Grafana
   * Network - a Docker network for the containers to use.  Has the advantage of providing a DNS service allowing the containers to communicate by name
   * Containers - Definitions of the running containers including exposed ports, environment variables to set and a bind mount definition for the Grafana container
