provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "aws-ami" {
  ami                    = "ami-034568121cfdea9c3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  # The <<-EOF and EOF are Terraform’s heredoc syntax, which allows
  # you to create multiline strings without having to insert \n characters
  # all over the place.
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World!" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
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
    from_port = var.server_port
    to_port   = var.server_port
    protocol  = "tcp"
    # This is a Terraform setting that allows all IP addresses to access the instance.
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
This is a Terraform variable that will be used to set the port the server will use for HTTP requests. instead of hardcoding the port repeatedly, we can use a variable.
*/
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

/*
This is a Terraform output that will print the public IP of the instance.
It will be printed in the console when we run terraform apply and it finishes.
The output will look like this:
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
Outputs:
public_ip = <public_ip>
*/
output "public_ip" {
  value       = aws_instance.aws-ami.public_ip
  description = "The public IP of the instance"
}
