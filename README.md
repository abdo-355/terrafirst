# Learning Terraform with AWS

This is a simple project to help me learn how to use Terraform with AWS.

## What does it do?

- **Creates a group of EC2 instances** that can scale automatically using an Auto Scaling Group
- **Sets up an Application Load Balancer (ALB)** to distribute web traffic to the instances
- **Configures security groups** so the web server is accessible from the internet
- **Uses data sources** to automatically find the default VPC and subnets

## Main AWS Resources Used

- `aws_launch_template`: Defines how the EC2 instances are set up
- `aws_autoscaling_group`: Manages scaling of the EC2 instances
- `aws_lb` and `aws_lb_listener`: Set up the load balancer and listen for HTTP requests
- `aws_lb_target_group`: Connects the load balancer to the instances
- `aws_security_group`: Controls network access

## How to use

1. Make sure you have Terraform and AWS credentials set up
2. Run these commands:
   ```bash
   terraform init
   terraform apply
   ```
3. After it finishes, Terraform will show you a DNS name for the load balancer. Open it in your browser to test the web server (you should see a "Hello, World!" message).

## Why?

I'm using this project to practice and understand the basics of Terraform and AWS, and to get hands-on experience with real cloud infrastructure.

## Clean up

To delete everything:

```bash
terraform destroy
```
