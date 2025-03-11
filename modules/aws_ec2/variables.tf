variable "intern_vpc_id" {
    type = string
    default = "vpc-03c07bf9acf7f3e5a"
    description = "VPC Id of the vpc I created for this task"
}

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

variable "key_pair" {
  type = string
  default = "kowsalya-west-key"  
  description = "key pair created in this region"
}

variable "subnet_id" {
  type = string
  default = "subnet-09a313e72aa2e2dd2"  
  description = "Subnet id of public subnet"   
}
variable "kms_key_id" {
  type = string
  default = "a711e547-2750-4ae2-b36a-e49ee07abfdf"     
  description = "KMS key id for EBS"
}

