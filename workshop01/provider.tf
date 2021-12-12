
  terraform {
        required_version = ">1.0.0"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.16.0"
      
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
  # Configuration options
  token = var.do_token
    
}
data "digitalocean_ssh_key" "ws" {
  name = "ws"
}