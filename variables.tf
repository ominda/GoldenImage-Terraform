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

variable "v_amis" {
  type = list(string)
}

variable "v_instance_type" {
  type = string
}

variable "v_ec2_kp" {
  type = string
}

variable "v_os_flavour" {
  type = list(string)
}

# variable "v_os_ami" {
#   type = map(object({
#     name = string
#     ami = string
#     type = string
#   }))
# }