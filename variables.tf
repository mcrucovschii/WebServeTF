#-----------------------------------------------
# Apache Web Server
#
# Build WebServer at bootstrap_action
# variables.tf = declaration of variables
#----------------------------------------------

variable "region" {
  description = "Please, enter AWS region"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "allowed_ports" {
  type    = list(any)
  default = ["22", "80", "443", "8080"]
}
