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
  description = "Please, enter instance type"
  default     = "t2.micro"
}
