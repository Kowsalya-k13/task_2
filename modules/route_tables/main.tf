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