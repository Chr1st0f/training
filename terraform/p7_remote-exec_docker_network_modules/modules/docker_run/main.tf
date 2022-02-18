terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
    host = "tcp://${var.ssh_host}:2375"
}

resource "docker_volume" "totof_vol_r" {

}
resource "docker_network" "totofnet_r" {
    name = "totofnet_n"
    driver = "bridge"
    ipam_config {
      subnet = "177.22.0.0/24"
    }
} 

resource "docker_image" "nginx_r" {
    name = "nginx:latest"
}
resource "docker_container" "nginx_r" {
    image = docker_image.nginx_r.latest
    name = "enginecks"
    ports {
        internal = 80
        external = 80
    }
    networks_advanced {
      name = docker_network.totofnet_r.name
      ipv4_address = "177.22.0.177"
    }
}