terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
   docker = {
      source = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

variable "host" {
  type = string
}

variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

provider "kubernetes" {
  host = "https://127.0.0.1:35211"
  config_path = "/home/ubuntu/.kube/config"
}

provider "docker" {
  host = "tcp://localhost:2376"
}

resource "kubernetes_deployment" "flaskapptf" {

 connection {
    type  = "ssh"
    host  = "192.168.1.208"
    user  = "ubuntu"
    port  = 22
    agent = true
  }

 provisioner "remote-exec" {
    inline = [
	  "pwd ",
      "mkdir testdirectory",
      "echo here in remote",
    ]
  }
}

}
