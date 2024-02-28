# create a vpc
resource "aws_vpc" "r_vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.project_name}-${var.environment}-Vpc"
  }
}

# Create a single public subnet. (Thats all we need for this project)
# It is nice to create multiple subnets with use of loops, if you need more subnets.
resource "aws_subnet" "r_public_subnet-01" {
  vpc_id     = aws_vpc.r_vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "${var.project_name}-${var.environment}-PublicSubnet01"
  }
}

# Create Internet Gateway for the VPC to have public access.
resource "aws_internet_gateway" "r_internet_gateway" {
  vpc_id = aws_vpc.r_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-IGW"
  }
}

# Attach IGW to the VPC
# resource "aws_internet_gateway_attachment" "r_internet_gateway_attachment" {
#   internet_gateway_id = aws_internet_gateway.r_internet_gateway.id
#   vpc_id              = aws_vpc.r_vpc.id
# }

# Create public route table
resource "aws_route_table" "r_public_route_table-01" {
  vpc_id = aws_vpc.r_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.r_internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-Public_rbt-01"
  }
}

# Attach route table to subnet
resource "aws_route_table_association" "r_route_table_association" {
  subnet_id      = aws_subnet.r_public_subnet-01.id
  route_table_id = aws_route_table.r_public_route_table-01.id
}