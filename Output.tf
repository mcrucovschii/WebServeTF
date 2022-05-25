# Output data

output "webserver_instance_id" {
  value = aws_instance.WebServer.id
}
output "webserver_public_dns" {
  value = aws_instance.WebServer.public_dns
}
