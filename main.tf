provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "aws-ami" {
  ami           = "ami-034568121cfdea9c3"
  instance_type = "t2.micro"
  tags = {
    Name = "my-micro-instance"
  }
}