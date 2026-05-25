

terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "6.23.0"
      }
    }
}

provider "aws"{
    region = var.region


}

resource "aws_instance" "mywebserver" {
    ami = "ami-0e12ffc2dd465f6e4"
    instance_type = "t3.micro"

ingress { 
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["66.249.66.42"]


    }

    tags = {
        Name = "sample server"
        
    }
  
}

