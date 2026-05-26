terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Check existing EC2 instances
data "aws_instances" "existing" {

  filter {
    name   = "tag:Name"
    values = ["sample-server"]
  }

  filter {
    name   = "instance-state-name"
    values = ["pending", "running", "stopped"]
  }
}

# Get existing instance details
data "aws_instance" "existing_server" {

  count = length(data.aws_instances.existing.ids) > 0 ? 1 : 0

  instance_id = data.aws_instances.existing.ids[0]
}

# Fetch latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create EC2 only if no instance exists
resource "aws_instance" "mywebserver" {

  count = length(data.aws_instances.existing.ids) == 0 ? 1 : 0

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  key_name = "mynewkey"

  vpc_security_group_ids = ["sg-05699f7bb60e9f9e0"]

  tags = {
    Name = "sample-server"
  }
}
