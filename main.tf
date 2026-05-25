
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Security Group
resource "aws_security_group" "web_sg" {
  name = "web-security-group"

  # SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["66.249.66.42/32"]
  }

  # Outbound Traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "mywebserver" {
  ami                    = "ami-0e12ffc2dd465f6e4"
  instance_type          = "t3.micro"
  key_name               = "mynewkey"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "sample-server"
  }
}


