#Security_group Creation
resource "aws_security_group" "intern_sg" {
  name        = "Intern-west-Security-Group"
  description = "Allow inbound traffic on port 22"
  vpc_id = var.intern_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name        = "Intern-West-Security-Group"
    Project     = "Terraform-Task"
    Owner       = "Kowsalya"
    Purpose     = "Security Group Created for Task"
    Created_On  = "March-10"

  }
}