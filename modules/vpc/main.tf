resource "aws_vpc" "intern_vpc" {  
    cidr_block = var.cidr_block      

    tags = {
        Name        = "intern-vpc"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Created VPC"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }
}
#Subnets
resource "aws_subnet" "public_subnet" {
    vpc_id            = aws_vpc.intern_vpc.id
    cidr_block        = var.public_cidr_1
    map_public_ip_on_launch = true

    tags = {
        Name        = "Kowsalya_Public_Subnet_1"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Public Subnet 1 Created for Task"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id     = aws_vpc.intern_vpc.id
    cidr_block = var.private_cidr

    tags = {
        Name        = "Kowsalya_Private_Subnet_1"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Private Subnet 1 Created for Task"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }
}

#ALB need atleast 2 public subnets and I do have one so creating the other
resource "aws_subnet" "public_subnet2" {
    vpc_id                  = aws_vpc.intern_vpc.id
    cidr_block              = var.public_cidr_2
    map_public_ip_on_launch = true
    availability_zone       = var.az_for_public_subnet_2

    tags = {
        Name        = "Kowsalya_Public_Subnet_2"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Public Subnet 2 Created for ALB in a different zone"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
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
    Created_On  = formatdate("YYYY-MM-DD", timestamp())
  }
}


