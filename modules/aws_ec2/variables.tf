variable "vpc_id" {}
variable "public_subnet_id" {}
variable "ami" {
    type = string
    default = "ami-0606dd43116f5ed57"
    description = "ami id for EC2 in public"
}

variable "instance_type" {
  type = string
  default = "t3.medium"    
  description = "instance type for ec2"
}
variable "my_ip" {
  type = string
  default = "106.222.198.47/32"    
  description = "My Local IP which changes on every power off of device"
}

variable "key_pair" {
  type = string
  default = "kowsalya-west-key"  
  description = "key pair created in this region"
}
variable "kms_key_id" {
  type = string
  default = "arn:aws:kms:us-west-2:130759691668:key/a711e547-2750-4ae2-b36a-e49ee07abfdf"     
  description = "KMS key id for EBS"
}

variable "epi_allocation_id" {
  type = string
  default = "eipalloc-0f6c22bd1f0d82e5d"     
  description = "Hardcoded because Created EIP for ec2 manually and added here"
}

