resource "aws_route_table" "pub-RT" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.gateway_id
    }
    tags = {
        Name        = "IternPublicRoute"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Public Route table Created for Task"
        Created_On  = "March-10"
    }
}

#associating public route with public subnet 
resource "aws_route_table_association" "public_association" {
    subnet_id = var.intern_public_subnet
    route_table_id = aws_route_table.pub-RT.id
}

#NAT 
resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
        Name        = "kowsalya-EIP"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Creating EIP for NAT"
        Created_On  = "March-10"
    }
    
}

resource "aws_nat_gateway" "internNat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = var.intern_private_subnet

    tags = {
        Name        = "InternNAT"
        Project     = "Terraform-Task"
        Owner       = "Kowsalya"
        Purpose     = "Creating NAT inside Private Subnet"
        Created_On  = "March-10"
    }
}