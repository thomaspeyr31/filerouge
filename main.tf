# ================================================
# MAIN — Ymmo Infrastructure
# Chef d'orchestre — appelle tous les modules
# ================================================

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
# MODULE 1 — VPC Siège
# ================================================
module "vpc_siege" {
  source = "./modules/vpc-siege"

  vpc_cidr            = "10.0.0.0/16"
  subnet_public_cidr  = "10.0.1.0/24"
  subnet_private_cidr = "10.0.10.0/24"
  subnet_data_cidr    = "10.0.20.0/24"
  az                  = var.az
}

# ================================================
# MODULE 2 — Security Groups
# ================================================
module "security_groups" {
  source = "./modules/security-groups"

  vpc_id              = module.vpc_siege.vpc_id
  subnet_private_cidr = "10.0.10.0/24"
  admin_ips           = var.admin_ips
  agences_cidrs       = [
    "10.1.0.0/16",  "10.2.0.0/16",  "10.3.0.0/16",
    "10.4.0.0/16",  "10.5.0.0/16",  "10.6.0.0/16",
    "10.7.0.0/16",  "10.8.0.0/16",  "10.9.0.0/16",
    "10.10.0.0/16", "10.11.0.0/16", "10.12.0.0/16",
  ]
}

# ================================================
# MODULE 3 — EC2
# ================================================
module "ec2" {
  source = "./modules/ec2"

  ami_ubuntu          = var.ami_ubuntu
  ami_windows         = var.ami_windows
  subnet_public_id    = module.vpc_siege.subnet_public_id
  subnet_private_id   = module.vpc_siege.subnet_private_id
  sg_bastion_id       = module.security_groups.sg_bastion_id
  sg_app_id           = module.security_groups.sg_app_id
  sg_dc_id            = module.security_groups.sg_dc_id
  ssh_public_key_path = var.ssh_public_key_path
}

# ================================================
# MODULE 4 — RDS MySQL
# ================================================
module "rds" {
  source = "./modules/rds"

  subnet_data_id    = module.vpc_siege.subnet_data_id
  subnet_private_id = module.vpc_siege.subnet_private_id
  sg_data_id        = module.security_groups.sg_data_id
  db_username       = var.db_username
  db_password       = var.db_password
}

# ================================================
# MODULE 5 — VPC Agences (x12)
# ================================================
module "agence_1" {
  source              = "./modules/vpc-agence"
  agence_num          = 1
  vpc_cidr            = "10.1.0.0/16"
  subnet_public_cidr  = "10.1.1.0/24"
  subnet_private_cidr = "10.1.10.0/24"
  az                  = var.az
}

module "agence_2" {
  source              = "./modules/vpc-agence"
  agence_num          = 2
  vpc_cidr            = "10.2.0.0/16"
  subnet_public_cidr  = "10.2.1.0/24"
  subnet_private_cidr = "10.2.10.0/24"
  az                  = var.az
}

module "agence_3" {
  source              = "./modules/vpc-agence"
  agence_num          = 3
  vpc_cidr            = "10.3.0.0/16"
  subnet_public_cidr  = "10.3.1.0/24"
  subnet_private_cidr = "10.3.10.0/24"
  az                  = var.az
}

module "agence_4" {
  source              = "./modules/vpc-agence"
  agence_num          = 4
  vpc_cidr            = "10.4.0.0/16"
  subnet_public_cidr  = "10.4.1.0/24"
  subnet_private_cidr = "10.4.10.0/24"
  az                  = var.az
}

module "agence_5" {
  source              = "./modules/vpc-agence"
  agence_num          = 5
  vpc_cidr            = "10.5.0.0/16"
  subnet_public_cidr  = "10.5.1.0/24"
  subnet_private_cidr = "10.5.10.0/24"
  az                  = var.az
}

module "agence_6" {
  source              = "./modules/vpc-agence"
  agence_num          = 6
  vpc_cidr            = "10.6.0.0/16"
  subnet_public_cidr  = "10.6.1.0/24"
  subnet_private_cidr = "10.6.10.0/24"
  az                  = var.az
}

module "agence_7" {
  source              = "./modules/vpc-agence"
  agence_num          = 7
  vpc_cidr            = "10.7.0.0/16"
  subnet_public_cidr  = "10.7.1.0/24"
  subnet_private_cidr = "10.7.10.0/24"
  az                  = var.az
}

module "agence_8" {
  source              = "./modules/vpc-agence"
  agence_num          = 8
  vpc_cidr            = "10.8.0.0/16"
  subnet_public_cidr  = "10.8.1.0/24"
  subnet_private_cidr = "10.8.10.0/24"
  az                  = var.az
}

module "agence_9" {
  source              = "./modules/vpc-agence"
  agence_num          = 9
  vpc_cidr            = "10.9.0.0/16"
  subnet_public_cidr  = "10.9.1.0/24"
  subnet_private_cidr = "10.9.10.0/24"
  az                  = var.az
}

module "agence_10" {
  source              = "./modules/vpc-agence"
  agence_num          = 10
  vpc_cidr            = "10.10.0.0/16"
  subnet_public_cidr  = "10.10.1.0/24"
  subnet_private_cidr = "10.10.10.0/24"
  az                  = var.az
}

module "agence_11" {
  source              = "./modules/vpc-agence"
  agence_num          = 11
  vpc_cidr            = "10.11.0.0/16"
  subnet_public_cidr  = "10.11.1.0/24"
  subnet_private_cidr = "10.11.10.0/24"
  az                  = var.az
}

module "agence_12" {
  source              = "./modules/vpc-agence"
  agence_num          = 12
  vpc_cidr            = "10.12.0.0/16"
  subnet_public_cidr  = "10.12.1.0/24"
  subnet_private_cidr = "10.12.10.0/24"
  az                  = var.az
}

# ================================================
# MODULE 6 — VPN Site-to-Site (x12)
# ================================================
module "vpn_agence_1" {
  source                 = "./modules/vpn"
  agence_num             = 1
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_1.nat_gateway_id
  agence_cidr            = "10.1.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_2" {
  source                 = "./modules/vpn"
  agence_num             = 2
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_2.nat_gateway_id
  agence_cidr            = "10.2.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_3" {
  source                 = "./modules/vpn"
  agence_num             = 3
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_3.nat_gateway_id
  agence_cidr            = "10.3.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_4" {
  source                 = "./modules/vpn"
  agence_num             = 4
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_4.nat_gateway_id
  agence_cidr            = "10.4.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_5" {
  source                 = "./modules/vpn"
  agence_num             = 5
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_5.nat_gateway_id
  agence_cidr            = "10.5.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_6" {
  source                 = "./modules/vpn"
  agence_num             = 6
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_6.nat_gateway_id
  agence_cidr            = "10.6.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_7" {
  source                 = "./modules/vpn"
  agence_num             = 7
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_7.nat_gateway_id
  agence_cidr            = "10.7.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_8" {
  source                 = "./modules/vpn"
  agence_num             = 8
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_8.nat_gateway_id
  agence_cidr            = "10.8.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_9" {
  source                 = "./modules/vpn"
  agence_num             = 9
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_9.nat_gateway_id
  agence_cidr            = "10.9.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_10" {
  source                 = "./modules/vpn"
  agence_num             = 10
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_10.nat_gateway_id
  agence_cidr            = "10.10.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_11" {
  source                 = "./modules/vpn"
  agence_num             = 11
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_11.nat_gateway_id
  agence_cidr            = "10.11.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}

module "vpn_agence_12" {
  source                 = "./modules/vpn"
  agence_num             = 12
  vpc_siege_id           = module.vpc_siege.vpc_id
  agence_public_ip       = module.agence_12.nat_gateway_id
  agence_cidr            = "10.12.0.0/16"
  route_table_private_id = module.vpc_siege.route_table_private_id
}
