# add new provider need to init
terraform {
  required_version = ">1.0.0"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.16.0"
    }
    local = {
        source = "hashicorp/local"
        version = "2.1.0"
    }
  }

  backend s3 {
    region = "sgp1"
    endpoint = "sgp1.digitaloceanspaces.com"
    bucket =  "qx-bucket"
    key = "states/code-server-deploy.tfstate"
    skip_credentials_validation = true
    skip_region_validation = true
    skip_metadata_api_check = true
  }
}

provider "digitalocean" {
  # Configuration options
  token = var.DO_token
}
