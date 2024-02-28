# VPC output values

output "o_vpc_id" {
  value = aws_vpc.r_vpc.id
}

output "o_public_subnet_id" {
  value = aws_subnet.r_public_subnet-01
}