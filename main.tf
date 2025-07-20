provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "aws-ami" {
  ami           = "ami-034568121cfdea9c3"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  
  # The <<-EOF and EOF are Terraform’s heredoc syntax, which allows
  # you to create multiline strings without having to insert \n characters
  # all over the place.
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World!" > index.html
    nohup busybox httpd -f -p 8080 &
  EOF

  # This is a Terraform setting that ensures the user_data script is
  # re-applied whenever the script changes, even if the instance is
  # already running. This is useful for updating the instance with
  # new scripts or configurations.
  user_data_replace_on_change = true


  tags = {
    Name = "my-micro-instance"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # This is a Terraform setting that allows all IP addresses to access the instance.
    cidr_blocks = ["0.0.0.0/0"]
  }
}