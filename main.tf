terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

# ================================================
# Données du VPC par défaut existant
# ================================================
data "aws_vpc" "default" {
  id = "vpc-037d38ccae9d45d25"
}

data "aws_subnet" "default" {
  id = "subnet-0c9be81d59b063a29"
}

# ================================================
# MODULE 1 — Security Groups
# ================================================
module "security_groups" {
  source = "./modules/security-groups"

  vpc_id              = data.aws_vpc.default.id
  subnet_private_cidr = data.aws_subnet.default.cidr_block
  admin_ips           = var.admin_ips
  agences_cidrs       = [
    "10.1.0.0/16",  "10.2.0.0/16",  "10.3.0.0/16",
    "10.4.0.0/16",  "10.5.0.0/16",  "10.6.0.0/16",
    "10.7.0.0/16",  "10.8.0.0/16",  "10.9.0.0/16",
    "10.10.0.0/16", "10.11.0.0/16", "10.12.0.0/16",
  ]
}

# ================================================
# MODULE 2 — EC2
# ================================================
module "ec2" {
  source = "./modules/ec2"

  ami_ubuntu          = var.ami_ubuntu
  ami_windows         = var.ami_windows
  subnet_public_id    = data.aws_subnet.default.id
  subnet_private_id   = data.aws_subnet.default.id
  sg_bastion_id       = module.security_groups.sg_bastion_id
  sg_app_id           = module.security_groups.sg_app_id
  sg_dc_id            = module.security_groups.sg_dc_id
  ssh_public_key_path = var.ssh_public_key_path
}

# ================================================
# MODULE 3 — RDS MySQL
# ================================================
module "rds" {
  source = "./modules/rds"

  subnet_data_id    = data.aws_subnet.default.id
  subnet_private_id = data.aws_subnet.default.id
  sg_data_id        = module.security_groups.sg_data_id
  db_username       = var.db_username
  db_password       = var.db_password
}
