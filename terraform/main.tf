provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami             = "ami-0e1bed4f06a3b463d"  
  instance_type   = "t2.micro"
  key_name        = "my-key"  # Update this to your actual key name
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "Ansible-Managed-Server"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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

output "instance_ip" {
  value = aws_instance.web.public_ip
}
