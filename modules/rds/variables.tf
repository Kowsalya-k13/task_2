variable "vpc_id" {}
variable "private_subnet_id" {}
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
  default = "kowsirds!"     
  description = "Password for DB"
}
variable "private_rds_cidr" {
  type    = string
  default = "12.0.5.0/24"
  description = "cidr block for private subnet 2 for RDS"
}
variable "availability_zone" {
  type = string
  default = "us-west-2a"
  description = "Availability zone for my 2nd private subnet - RDS"
}