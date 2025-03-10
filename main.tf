module "inter_vpc" {
    source     = "./modules/vpc"
}

module "iam_role" {
    source     = "./modules/iam_role"
}

module "aws_ec2" {
    source     = "./modules/aws_ec2"
}