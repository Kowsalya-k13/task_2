# Security Group for ALB
resource "aws_security_group" "alb_security_group" {
  name        = "kowsalya-alb-sg"
  description = "Created for ALB to allow HTTP port 80"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name        = "kowsalya-alb-sg"
    Project     = "Terraform-Task"
    Owner       = "Kowsalya"
    Purpose     = "Security Group Created for ALB"
    Created_On  = "March-13"

  }
}

# Security Group for ASG EC2 instances
resource "aws_security_group" "instances_sg" {
  name        = "instances-security-group"
  description = "To allow traffic only from ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Target Group for ALB
resource "aws_lb_target_group" "asg_tg" {
  name     = "kowsalya-asg-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "kowsalya-asg-target-group"
    Project     = "Terraform-Task"
    Owner       = "Kowsalya"
    Purpose     = "Target Group Created for ALB"
    Created_On  = "March-13"

  }
}

