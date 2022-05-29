#-----------------------------------------------
# Apache Web Server
#
# Build WebServer at bootstrap_action
# terraform.tfvars = default values of variables
#----------------------------------------------

region        = "us-west-1"
instance_type = "t2.micro"
allowed_ports = ["22", "80", "8080", "443"]
