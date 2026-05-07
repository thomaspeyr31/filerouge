variable "agence_num" {
  description = "Numéro de l'agence (1 à 12)"
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR du VPC agence (ex: 10.1.0.0/16)"
  type        = string
}

variable "subnet_public_cidr" {
  description = "CIDR subnet public agence (ex: 10.1.1.0/24)"
  type        = string
}

variable "subnet_private_cidr" {
  description = "CIDR subnet privé agence (ex: 10.1.10.0/24)"
  type        = string
}

variable "az" {
  description = "Availability Zone AWS"
  type        = string
  default     = "eu-west-3a"
}

variable "vpn_gateway_id" {
  description = "ID de la VPN Gateway agence (fourni par le module VPN)"
  type        = string
  default     = ""
}
