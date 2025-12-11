output "aws_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
  
}

output "ec2-public_ip" {
  value = aws_instance.myapp-server.public_ip
}