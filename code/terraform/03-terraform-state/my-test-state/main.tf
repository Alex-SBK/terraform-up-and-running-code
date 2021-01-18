
terraform {
    backend "s3" {
        # Replace this with your bucket name!
        bucket = "terraform-up-and-running-state"
        key = "stage/data-stores/mysql/terraform.tfstate"
        region = "us-east-2"
        # Replace this with your DynamoDB table name!
        dynamodb_table = "terraform-up-and-running-locks"
        encrypt = true
    }
}

provider "aws" {
    region = "eu-central-1"
}

resource "aws_db_instance" "example_db_name" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mariadb"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "example_database"
  username = "admin"

  # How should we set the password?

password ="123456Aa"
}

# data "aws_secretsmanager_secret_version" "db_password" {
#   secret_id = "mysql-master-password-stage"
# }
