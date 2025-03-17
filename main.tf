module "intern_vpc" {
    source     = "./modules/vpc"
}

module "route_tables" {
    source     = "./modules/route_tables"
    vpc_id              = module.intern_vpc.vpc_id
    public_subnet_id    = module.intern_vpc.public_subnet_id
    public_subnet_2_id  = module.intern_vpc.public_subnet_2_id
    private_subnet_id   = module.intern_vpc.private_subnet_id
    igw_id              = module.intern_vpc.igw_id
}

module "aws_ec2" {
    source     = "./modules/aws_ec2"
    vpc_id              = module.intern_vpc.vpc_id
    public_subnet_id    = module.intern_vpc.public_subnet_id 
}

module "aws_rds" {
    source     = "./modules/rds"
    vpc_id              = module.intern_vpc.vpc_id
    private_subnet_id   = module.intern_vpc.private_subnet_id
}

module "alb_asg" {
    source     = "./modules/alb_asg"
    vpc_id              = module.intern_vpc.vpc_id
    public_subnet_id    = module.intern_vpc.public_subnet_id
    public_subnet_2_id  = module.intern_vpc.public_subnet_2_id
    private_subnet_id   = module.intern_vpc.private_subnet_id
    private_subnet_2_RDS = module.aws_rds.private_subnet_2_id
}
module "lock_tf" {
    source     = "./modules/lock_tf"
}