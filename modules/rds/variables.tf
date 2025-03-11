variable "subnet_id" {
  type = string
  default = "subnet-08cb7ba68adfcb996"  
  description = "Subnet id of private subnet"   
}

variable "rds_kms_key_id" {
  type = string
  default = "arn:aws:kms:us-west-2:130759691668:key/38861bc3-f045-4fc6-9253-aa67ad4637b4"     
  description = "KMS key id for RDS"
}

variable "db_username" {
  type = string
  default = "kowsalya"     
  description = "Username for DB"
}
variable "db_password" {
  type = string
  default = "kowsi@rds"     
  description = "Password for DB"
}
variable "vpc_id" {
  type    = string
  default = "vpc-03c07bf9acf7f3e5a"
  description = "VPC ID I created"
}

variable "private_rds_cidr" {
  type    = string
  default = "12.0.5.0/24"
  description = "cidr block for private subnet 2 for RDS"
}