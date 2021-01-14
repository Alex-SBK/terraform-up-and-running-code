terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_instance" "example_1" {
  count         = 3
  ami           = "ami-0e1ce3e0deb8896d2"
  instance_type = "t2.micro"
}

resource "aws_instance" "example_2" {
  count             = length(data.aws_availability_zones.all.names)
  availability_zone = data.aws_availability_zones.all.names[count.index]
  ami               = "ami-0e1ce3e0deb8896d2"
  instance_type     = "t2.micro"
}

data "aws_availability_zones" "all" {}

