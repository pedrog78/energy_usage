terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}


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
  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name="energy_network"
  }
}

#MySQL
resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "MySQL_consumption"
  env = [ "MYSQL_RANDOM_ROOT_PASSWORD=yes"]
  
  ports {
    internal = 3306
    external = 3306
  }
  networks_advanced {
    name="energy_network"
  }

}

