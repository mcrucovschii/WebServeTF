provider "aws" {
  region = "us-west-1"
  data "aws_availability_zone" "working" {}
  data "aws_caller_identity" "current" {}
  data "aws_region" "current" {}
  data "aws_vpcs" "current" {}

  data "aws_ami" "fresh_amazon_linux"
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20210721.2-x86_64-gp2"]
  }
}
