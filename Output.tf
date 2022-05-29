# Output data

output "webserver_instance_id" {
  value = aws_instance.WebServer.id
}
output "webserver_public_dns" {
  value = aws_instance.WebServer.public_dns
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
data "aws_ami" "fresh_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_regions_name" {
  value = data.aws_region.current.name
}

output "latest_amazon_linux_id" {
  value = data.aws_ami.fresh_amazon_linux.id
}
