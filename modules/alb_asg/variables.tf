variable "vpc_id" {
  type    = string
  default = "vpc-03c07bf9acf7f3e5a"
  description = "VPC ID I created"
}

variable "public_subnet_1" {
  type    = string
  default = "subnet-09a313e72aa2e2dd2"
  description = "Public Subnet 1 for ALB in us-west-2d"
}
variable "public_subnet_2" {
  type    = string
  default = "subnet-04bcffea62bbdcab9"
  description = "Public subnet 2 for ALB in us-west-2a"
}

variable "ami" {
    type = string
    default = "ami-0606dd43116f5ed57"
    description = "ami id for ASG EC2s"
}

variable "private_subnet_1" {
  type    = string
  default = "subnet-08cb7ba68adfcb996"
  description = "Private Subnet 1 for ASG in us-west-2d"
}
variable "private_subnet_2" {
  type    = string
  default = "subnet-033c898124610d218"
  description = "Private subnet 2 for ASG in us-west-2a"
}

