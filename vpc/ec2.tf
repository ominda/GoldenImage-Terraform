# Create security group for public instance
resource "aws_security_group" "r_public_instance-sg" {
  name        = "${var.project_name}-${var.environment}-Public-SG"
  description = "Allow ssh and SSM inbound traffic"
  vpc_id      = aws_vpc.r_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-Public-SG"
  }
}

#### >> need to develop below << ####
resource "aws_vpc_security_group_ingress_rule" "r_allow_ssh" {
  security_group_id = aws_security_group.r_public_instance-sg.id
  cidr_ipv4         = var.jump_server
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "r_allow_https" {
  security_group_id = aws_security_group.r_public_instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "r_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.r_public_instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Amazon Linux 2 AMI (HVM)
resource "aws_instance" "r_amazon_linux2" {
  ami                         = var.amazon_linux2_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = var.ec2_kp
  vpc_security_group_ids      = [aws_security_group.r_public_instance-sg.id]
  subnet_id                   = aws_subnet.r_public_subnet-01.id
  iam_instance_profile        = aws_iam_instance_profile.r_instance_profile.name
  #### >> update below parameters << ####

  #   user_data = ""

  tags = {
    Name = "${var.project_name}-${var.environment}-Amazon_Linux2"
  }
}