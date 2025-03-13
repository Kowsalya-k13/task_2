module "inter_vpc" {
    source     = "./modules/vpc"
}

module "route_tables" {
    source     = "./modules/route_tables"
}

module "aws_ec2" {
    source     = "./modules/aws_ec2"
}

module "aws_rds" {
    source     = "./modules/rds"
}

module "alb_asg" {
    source     = "./modules/alb_asg"
}