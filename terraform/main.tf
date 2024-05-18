provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "ec2" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_default_security_group.web_sg.id]

  key_name = var.key_name

  tags = {
    Name = "Ansible-Nginx-Server"
  }
}
  resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  resource"local_file" "local-exec" {
    filename = "../ansible/inventory"
    content  = "[web]/n${aws_instance.ec2.public_ip}"
  }


output "instance_ip" {
  value = aws_instance.ec2.public_ip
}
