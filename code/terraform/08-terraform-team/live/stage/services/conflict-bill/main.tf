terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_instance" "foo" {
  ami           = "ami-0e1ce3e0deb8896d2"
  instance_type = "t2.micro"

  tags = {
    Name = "foo"
  }
}

