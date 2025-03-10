module "inter_vpc" {
    source     = "./modules/vpc"
}

module "iam_role" {
    source     = "./modules/iam_role"
}