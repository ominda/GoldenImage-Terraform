module "m_vpc" {
  source             = "./vpc"
  project_name       = var.v_project_name
  environment        = var.v_environment
  cidr               = var.v_vpc_cidr
  public_subnet_cidr = var.v_public_subnet_cidr
  jump_server        = var.v_jump_server_ip
  amis               = var.v_amis
  instance_type      = var.v_instance_type
  ec2_kp             = var.v_ec2_kp
  os_flavour         = var.v_os_flavour
  # amis = var.v_os_ami
  # os_flavour = var.v_os_ami
}