# Output data

output "webserver_instance_id" {
  value = aws_instance.WebServer.id
}
output "webserver_public_dns" {
  value = aws_instance.WebServer.public_dns
}
output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_regions_name" {
  value = data.aws_region.current.name
}

output "aws_vpcs" {
  value = data.vpcs.current.ids
}
