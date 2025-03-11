module "inter_vpc" {
    source     = "./modules/vpc"
}

# module "iam_role" {
#     source     = "./modules/iam_role"
# }

module "route_tables" {
    source     = "./modules/route_tables"
}

module "aws_ec2" {
    source     = "./modules/aws_ec2"
}

# module "aws_rds" {
#     source     = "./modules/rds"
# }