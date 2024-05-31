terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

#### Set up input variables
variable "mysql_pass" {
  type=string
  description="The initial root password that will be set for mysql"
  sensitive=true
}

variable "grafana_datasource" {
  type=string
  description="Absolute path to the datasource directory to be mounted"
}

variable "mysql_grafana_user" {
  type=string
  description="Read only user for the mysql datasource"
}

variable "mysql_grafana_user_pass" {
  type=string
  description="Password for the mysql datasource"
  sensitive=true
}

#### Image resource definitions

resource "docker_image" "mysql" {
  name         = "mysql:latest"
  keep_locally = false
}

resource "docker_image" "grafana" {
  name         = "grafana/grafana"
  keep_locally = false
}


#### Docker network
resource "docker_network" "energy_network" {
   name = "energy_network"
}




#### Container resource definistions

#Grafana
resource "docker_container" "grafana" {
  image = docker_image.grafana.image_id
  name  = "grafana_dashboards"
  env = [ "GRAFANAUSER=${var.mysql_grafana_user}",
          "GRAFANAUSERPASS=${var.mysql_grafana_user_pass}"
        ]
  ports {
    internal = 3000
    external = 3000
  }
  volumes {
    read_only = true
    host_path= "${var.grafana_datasource}"
    container_path="/etc/grafana/provisioning/datasources"

  }
  networks_advanced {
    name="energy_network"
  }
}

#MySQL
resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "MySQL_consumption"
  env = [ "MYSQL_ROOT_PASSWORD=${var.mysql_pass}"]
  
  ports {
    internal = 3306
    external = 3306
  }
  networks_advanced {
    name="energy_network"
  }

}

