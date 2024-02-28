terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      project-name = var.v_project_name
      environment  = var.v_environment
      contact      = var.v_project_owner
    }
  }
}