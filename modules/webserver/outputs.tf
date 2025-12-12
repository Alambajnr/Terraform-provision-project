output "security_group_id" {
  value = aws_security_group.myapp-sg.id
}

output "instance_id" {
  value = aws_instance.myapp-server.id
}

output "public_ip" {
  value = aws_instance.myapp-server.public_ip
}