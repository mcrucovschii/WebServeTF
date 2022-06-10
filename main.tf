#-----------------------------------------------
# Apache Web Server
#
# Build WebServer with bootstrap_action
# can we be used for mass deployment
# maim.tf
#----------------------------------------------

provider "aws" {
  region = var.region
  credentials "app.terraform.io" {
    token = "xxxxxxxxxxxxxxxxxxxxx"
  }
}
terraform {

  cloud {
    organization = "EasyBreeze"
    workspaces {
      name = "gh-actions-demo"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }
}
