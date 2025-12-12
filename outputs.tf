
output "webserver_sg_id" {
  value = module.myapp-webserver.security_group_id
}

output "webserver_public_ip" {
  value = module.myapp-webserver.public_ip
}