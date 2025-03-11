#Security_group Creation for rds
resource "aws_security_group" "rds" {
  name        = "Intern-RDS-Security-Group"
  description = "Allow inbound traffic on port 3306 Mysql Port"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["12.0.0.0/16"] 
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Intern-RDS-Security-Group"
    Project     = "Terraform-Task"
    Owner       = "Kowsalya"
    Purpose     = "Security Group Created for RDS"
    Created_On  = "March-11"
  }
}

#We need subnet group for RDS 
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "intern-rds-subnet-group"
  subnet_ids = [var.subnet_id]

  tags = {
    Name = "Intern RDS Subnet Group"
  }
}
#RDS instance
resource "aws_db_instance" "low_cost_rds" {
  identifier           = "intern-rds"
  engine              = "mysql"  
  engine_version      = "8.0"    
  instance_class      = "db.t3.micro"  
  allocated_storage   = 20  
  storage_type        = "gp2"
  storage_encrypted   = true
  kms_key_id          = var.rds_kms_key_id

  username            = var.db_username
  password            = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = []

  multi_az           = false 
  publicly_accessible = false
  backup_retention_period = 7
  skip_final_snapshot = true

  tags = {
    Name        = "Private RDS Instance"
    Project     = "Terraform-RDS"
    Owner       = "Kowsalya"
    Purpose     = "RDS in Private Subnet"
    Created_On  = "March-11"
  }
}
