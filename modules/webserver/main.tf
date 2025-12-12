resource "aws_security_group" "myapp-sg" {
  name = "${var.env_prefix}-sg"
  vpc_id = var.vpc_id
  description = "Security group for ${var.env_prefix} application"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_prefix}-sg"
  }
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.image_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
  
}


/*resource "aws_key_pair" "ssh" {
  key_name   = "dev-key"
  public_key = var.public_key_location
}*/
  


resource "aws_instance" "myapp-server" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type

  subnet_id     = var.subnet_id
  security_groups = [aws_security_group.myapp-sg.id] 
  availability_zone = var.avail_zone

  associate_public_ip_address = true
  key_name   = "devops-key"
   
  user_data = file("${path.module}/userdata.sh")

  user_data_replace_on_change = true

  tags = {
    Name = "${var.env_prefix}-server"
  } 
}