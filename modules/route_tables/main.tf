resource "aws_route_table" "public_route_table" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id
    }
    tags = {
        Name        = "IternPublicRoute"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Public Route table for public subnet 1"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }
}

#associating public route with public subnet 
resource "aws_route_table_association" "public_association" {
    subnet_id = var.public_subnet_id
    route_table_id = aws_route_table.public_route_table.id
}

#NAT 
resource "aws_eip" "nat_eip" {
    domain = "vpc"
    
    tags = {
        Name        = "EIP_for_NAT"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Creating EIP for NAT"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }
    
}

resource "aws_nat_gateway" "NatGateway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = var.private_subnet_id

    tags = {
        Name        = "InternNAT"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Creating NAT inside Private Subnet"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }
}

#Private route table 
resource "aws_route_table" "private_route_table" {
    vpc_id =  var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.NatGateway.id
    }
    tags = {
        Name        = "InternPrivateRoute"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Private Route table Created for Private Subnet"
        Created_On  = formatdate("YYYY-MM-DD", timestamp())
    }
}

#associating private route with private subnet 
resource "aws_route_table_association" "private_association" {
    subnet_id = var.private_subnet_id
    route_table_id = aws_route_table.private_route_table.id
}