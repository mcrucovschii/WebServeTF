#-----------------------------------------------
# Apache Web Server
#
# Build WebServer at bootstrap_action
# terraform.tfvars = default values of variables
#----------------------------------------------

region        = "us-west-2"
instance_type = "t2.micro"
allowed_ports = ["22", "80", "8080", "443"]
key_max_name  = "MaxKeyPairDel"
