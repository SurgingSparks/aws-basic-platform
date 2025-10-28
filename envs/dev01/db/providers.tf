terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project      = var.project
      Environment  = var.environment
      Owner        = var.owner
      CostCenter   = var.cost_center
      ManagedBy    = "terraform"
    }
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket         = "tf-state-testing-2025"
    key            = "envs/dev01/network/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "tf-state-locks"
    encrypt        = true
  }
}

data "aws_vpc" "main" {
  id = data.terraform_remote_state.network.outputs.vpc_id
}

locals {
  dev01_vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  dev01_private_subnet_id  = data.terraform_remote_state.network.outputs.private_subnet_id
  dev01_vpc_cidr           = data.aws_vpc.main.cidr_block
}

