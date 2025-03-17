variable "vpc_id" {}
variable "public_subnet_id" {}
variable "public_subnet_2_id" {}
variable "private_subnet_id" {}
variable "private_subnet_2_RDS"{}

variable "ami" {
    type = string
    default = "ami-0606dd43116f5ed57"
    description = "ami id for ASG EC2s"
}

variable "email_ids" {
  description = "List of email addresses to subscribe to the SNS topic"
  type        = list(string)
  default     = ["kowsalya.kumar@batonsystems.com", "durga.sathyanps@batonsystems.com"]
}

