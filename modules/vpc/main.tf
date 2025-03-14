resource "aws_vpc" "intern_vpc" {  
    cidr_block = var.cidr_block      

    tags = {
        Name        = "intern-vpc"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Created VPC"
        Created_On  = "March-10"
    }
}
#Subnets
resource "aws_subnet" "public_subnet" {
    vpc_id            = aws_vpc.intern_vpc.id
    cidr_block        = var.public_cidr
    map_public_ip_on_launch = true

    tags = {
        Name        = "Kowsalya_Public_Subnet"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Public Subnet Created for Task"
        Created_On  = "March-10"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id     = aws_vpc.intern_vpc.id
    cidr_block = var.private_cidr

    tags = {
        Name        = "Kowsalya_Private_Subnet"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Private Subnet Created for Task"
        Created_On  = "March-10"
    }
}

#InternetGateway 
resource "aws_internet_gateway" "intern-igw" {
  vpc_id = aws_vpc.intern_vpc.id
  tags = {
    Name        = "InternInternetGateway"
    Project     = "Terraform-Task"
    Owner       = "Kowsalya"
    Purpose     = "Internet Gateway Created inside VPC I created"
    Created_On  = "March-10"
  }
}
