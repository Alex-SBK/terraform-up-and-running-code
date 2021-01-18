provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0e1ce3e0deb8896d2"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}

terraform {
  backend "s3" {
      bucket            = "terraform-up-and-running-state-gamlemister"
      key               = "workspaces-example/terraform.tfstate"
      region            = "eu-central-1"

      dynamodb_table    = "terraform-up-and-running-locks"
      encrypt           = true
  }
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-up-and-running-state-gamlemister"

    # # Prevent accidential deletion of this S3 bucket
    # lifecycle {
    # # prevent_destroy = true
    # }

    # Enable versioning so we can see the full revision history 
    # of our state files

    versioning {
    enabled = false
    }

    # Enable servier-side encryption by default
    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }

}


resource "aws_dynamodb_table" "terraform_locks_dynamodb_gamle" {
  name = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}