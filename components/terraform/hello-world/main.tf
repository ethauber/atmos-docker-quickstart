terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

variable "tenant" {
  type        = string
  description = "The tenant name (e.g. 'local')"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g. 'test')"
}

variable "stage" {
  type        = string
  description = "The stage name (e.g. 'dev')"
}

variable "container_name" {
  type    = string
  default = "atmos-demo-nginx"
}

variable "external_port" {
  type    = number
  default = 8080
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name
  ports {
    internal = 80
    external = var.external_port
  }
}

output "url" {
  value = "http://localhost:${var.external_port}"
}