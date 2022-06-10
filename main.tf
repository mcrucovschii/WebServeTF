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
    token = "L6AAozApBakm2Q.atlasv1.6SjPzfyPurBdB5eFUkS4uLUwAtaS5h1DB1yIifQ1knmYfTgd3aXZXp0oZEMyOJ8I6j8"
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
