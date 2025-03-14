#Security_group Creation
resource "aws_security_group" "intern_sg" {
  name        = "Intern-west-Security-Group"
  description = "Allow inbound traffic on port 22"
  vpc_id = var.intern_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.222.197.92/32"] #My IP
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

#EC2 instance
resource "aws_instance" "ec2inPublic" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_pair
    subnet_id = var.subnet_id
    vpc_security_group_ids  = [aws_security_group.intern_sg.id]

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
        Created_On  = "March-11"
    }

    lifecycle {
        ignore_changes = [iam_instance_profile]
    }
    
}
resource "aws_eip_association" "eip_attach" {
  instance_id   = aws_instance.ec2inPublic.id
  allocation_id = "eipalloc-00f0115b601e756e5"  
} 