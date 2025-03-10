module "vpc" {
  source = "./modules/vpc"
}
variable "vpc_id" {
  type    = string
  default = module.vpc.vpc_id
}
variable "gateway_id" {
  type    = string
  default = module.vpc.igw_id
}

variable "intern_public_subnet" {
  type    = string
  default = module.vpc.public_subnet_id
}

variable "intern_private_subnet" {
  type    = string
  default = module.vpc.private_subnet_id
}