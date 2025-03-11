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
  vpc_security_group_ids = [var.rds_security_group]

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
