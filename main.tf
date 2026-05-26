
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

# Fetch latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create EC2 Instance
resource "aws_instance" "mywebserver" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  key_name = "mynewkey"

  vpc_security_group_ids = ["sg-05699f7bb60e9f9e0"]

  tags = {
    Name = "sample-server"
  }
}
