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
	password ="great"
    port  = 22
    agent = true
	timeout ="30s"
  }

 provisioner "remote-exec" {
    inline = [
	  "pwd ",
      "mkdir testdirectory",
      "echo here in remote",
    ]
  }
    
}

resource "kubernetes_service" "flaskapptf" {
  metadata {
    name = "flaskapptf-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.flaskapptf.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 8080
      target_port = 8080
    }

    type = "NodePort"
  }
}
