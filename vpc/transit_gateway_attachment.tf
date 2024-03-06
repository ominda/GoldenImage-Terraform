resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
  subnet_ids         = [aws_subnet.r_public_subnet-01.id]
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = aws_vpc.r_vpc.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "${var.project_name}-${var.environment}-TGW-Attachment"
  }
}