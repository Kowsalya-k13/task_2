#Security_group Creation
resource "aws_security_group" "intern_security_group" {
  name        = "Intern-west-Security-Group"
  description = "Allow inbound traffic on port 22"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
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
    Purpose     = "Security Group Created for EC2 in public subnet 1"
    Created_On  = formatdate("YYYY-MM-DD", timestamp())

  }
}

#EC2 instance
resource "aws_instance" "ec2inPublic" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_pair
    subnet_id = var.public_subnet_id
    vpc_security_group_ids  = [aws_security_group.intern_security_group.id]

    root_block_device {
        volume_size           = 8
        delete_on_termination = true
        encrypted             = true
        kms_key_id            = var.kms_key_id
    }

    tags = {
        Name        = "Instance-in-public"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Creating instance inside Public Subnet as instructed"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }
}
#Created EIP for ec2 manually and added here
resource "aws_eip_association" "eip_attach" {
  instance_id   = aws_instance.ec2inPublic.id
  allocation_id = var.epi_allocation_id
} 