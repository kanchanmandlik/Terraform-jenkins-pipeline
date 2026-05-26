
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

resource "aws_instance" "mywebserver" {
  ami           = "ami-0e12ffc2dd465f6e4"
  instance_type = "t3.micro"

data "aws_instance" "foobar"{
    filter {
        tags   = "ami-0e12ffc2dd465f6e4"
        values = ["foobar"]
  }
    most_recent = true

  key_name = "mynewkey"

  vpc_security_group_ids = ["sg-05699f7bb60e9f9e0"]

  tags = {
    Name = "sample-server"
  }
}

