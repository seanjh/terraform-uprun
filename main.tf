provider "aws" {
  region  = "us-east-1"
  version  = "~>2.53"
}

resource "aws_instance" "example" {
  ami           = "ami-0fc61db8544a617ed"
  instance_type = "t2.micro"
  
  tags = {
    Name = "terraform-example"
  }
}
