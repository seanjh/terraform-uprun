provider "aws" {
  region  = "us-east-1"
  version = "~> 2.56"
}

#data "aws_ssm_parameter" "mysql_example_password" {
#name            = "mysql-example-password"
#with_decryption = true
#}

resource "aws_ssm_parameter" "foo" {
  name        = "mysql-example-password"
  description = "The MySQL administrator password"
  type        = "SecureString"
  value       = "bar"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  password            = var.db_password
  skip_final_snapshot = true
}

terraform {
  backend "s3" {
    bucket = "seanjh-terraform-up-and-running-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
