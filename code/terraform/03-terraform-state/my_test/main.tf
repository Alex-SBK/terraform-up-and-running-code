provider "aws" {
    region = "eu-central-1"
}
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-up-and-running-state"

# Prevent accidential deletion of this S3 bucket
lifecycle {
  prevent_destroy = yes
}

# Enable versioning so we can see the full revision history 
# of our state files


}
