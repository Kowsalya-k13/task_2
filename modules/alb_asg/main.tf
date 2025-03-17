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
    Created_On  = formatdate("YYYY-MM-DD", timestamp())

  }
}

# Security Group for ASG EC2 instances
resource "aws_security_group" "ec2_instance_security_group" {
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

    tags = {
    Name        = "kowsalya-ASG-ec2-security-group"
    Project     = "Terraform-Task"
    Owner       = "Kowsalya"
    Purpose     = "Security Group Created for ASG EC2s"
    Created_On  = formatdate("YYYY-MM-DD", timestamp())
  }
}

#Target Group for ALB
resource "aws_lb_target_group" "auto_scalling_target_group" {
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
    Created_On  =  formatdate("YYYY-MM-DD", timestamp())

  }
}
# ALB
resource "aws_lb" "application_load_balancer" {
  name               = "kowsalya-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [var.public_subnet_id, var.public_subnet_2_id] 

  tags = {
    Name        = "kowsalya-load-balancer"
    Project     = "Terraform-Task"
    Owner       = "Kowsalya"
    Purpose     = "Created ALB for the task"
    Created_On  = formatdate("YYYY-MM-DD", timestamp())
  }
}


#ALB Listeners
resource "aws_lb_listener" "http_listeners" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"  #to target groups and I have mentioned in ASG target groups
    target_group_arn = aws_lb_target_group.auto_scalling_target_group.arn
  }
}

#Launch Template
resource "aws_launch_template" "asg-template" { 
    name          = "kowsalya-asg-launch-template"
    image_id      = var.ami
    instance_type = "t3.medium"
    network_interfaces {
        security_groups             = [aws_security_group.ec2_instance_security_group.id]
        associate_public_ip_address = true
    }

    user_data = base64encode(<<-EOF
        #!/bin/bash
        sudo hostnamectl set-hostname AUTOSCALED-INSTANCE-KOWSALYA
    EOF
    )
    tags = {
        Name        = "kowsalya-asg-launch-template"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Created ASG Launch template"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }

}

#Auto Scaling Group
resource "aws_autoscaling_group" "autoscaling_group" {
  name = "kowsalya-asg"  
  desired_capacity     = 2
  min_size            = 1
  max_size            = 3
  
  vpc_zone_identifier = [var.private_subnet_id, var.private_subnet_2_RDS ] #private subnets

  launch_template {
    id      = aws_launch_template.asg-template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.auto_scalling_target_group.arn]
  health_check_type = "EC2"
}
#Policies for scalling up and scalling down 
resource "aws_autoscaling_policy" "ec2_scale_up" {
  name                   = "kowsalya-scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown              = 300  #seconds
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
}
resource "aws_autoscaling_policy" "ec2_scale_down" {
  name                   = "kowsalya-scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown              = 300  #seconds
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

#Cloud Watch Alarm for >70% CPU 
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "scale-up-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60 #seconds
  statistic           = "Average"
  threshold           = 70 #cpu utilization %
  alarm_description   = "Monitors and Scale up when CPU utilization exceeds 70%"
  actions_enabled     = true

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }

  alarm_actions = [aws_autoscaling_policy.ec2_scale_up.arn]
}
#Cloud Watch Alarm for <30% CPU 
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "scale-down-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60 #seconds
  statistic           = "Average"
  threshold           = 30 #cpu utilization %
  alarm_description   = "Monitors and Scale down when CPU utilization is below 30%"
  actions_enabled     = true

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }

  alarm_actions = [aws_autoscaling_policy.ec2_scale_down.arn]
}

#SNS Alerts
resource "aws_sns_topic" "ec2_alerts" {
  name = "kowsalya-alerts"
}
#For email alerts
resource "aws_sns_topic_subscription" "email_subscriptions" {
  count = length(var.email_ids)
  topic_arn = aws_sns_topic.ec2_alerts.arn
  protocol = "email"
  endpoint = var.email_ids[count.index]
}

# SNS to CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "cpu_alert_alarm" {
  alarm_name          = "cpu-utilization-alert"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60 #seconds
  statistic           = "Average"
  threshold           = 70 #cpu utilization %
  alarm_description   = "Trigger SNS alert if CPU exceeds 70%"
  actions_enabled     = true

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }

  alarm_actions = [aws_sns_topic.ec2_alerts.arn]
}






