variable "agence_num" {
  description = "Numéro de l'agence (1 à 12)"
  type        = number
}

variable "vpc_siege_id" {
  description = "ID du VPC siège"
  type        = string
}

variable "agence_public_ip" {
  description = "IP publique de la NAT Gateway de l'agence"
  type        = string
}

variable "agence_cidr" {
  description = "CIDR du VPC agence (ex: 10.1.0.0/16)"
  type        = string
}

variable "route_table_private_id" {
  description = "ID route table subnet privé siège"
  type        = string
}
