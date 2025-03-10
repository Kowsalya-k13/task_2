module "vpc" {
  source = "./modules/vpc"
}
variable "vpc_id" {
  type    = string
  default = "vpc-03c07bf9acf7f3e5a"
}
variable "gateway_id" {
  type    = string
  default = "igw-0bcd56c9d11fc662a"
}

variable "intern_public_subnet" {
  type    = string
  default = "subnet-09a313e72aa2e2dd2"
}

variable "intern_private_subnet" {
  type    = string
  default = "subnet-08cb7ba68adfcb996"
}