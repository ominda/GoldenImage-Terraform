resource "aws_vpc" "r_golden_image-vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.project_name}-${var.environment}-Vpc"
  }
}