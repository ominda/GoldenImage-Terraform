# Common Variables
variable "v_environment" {
  type = string
}

variable "v_project_name" {
  type = string
}

variable "v_project_owner" {
  type = string
}

# Module VPC Variables
variable "v_vpc_cidr" {
  type = string
}

variable "v_public_subnet_cidr" {
  type = string
}
variable "v_jump_server_ip" {
  type = string
}

variable "v_amazon_linux2_ami" {
  type = string
}

variable "v_instance_type" {
  type = string
}

variable "v_ec2_kp" {
  type = string
}