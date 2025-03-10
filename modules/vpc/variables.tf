variable "cidr_block" {
  type = string
  default = "12.0.0.0/16"
}

variable "public_cidr" {
  type = string
  default = "12.0.6.0/24"
}
variable "private_cidr" {
  type = string
  default = "12.0.8.0/24"
}