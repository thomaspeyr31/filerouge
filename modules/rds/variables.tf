variable "subnet_data_id" {
  description = "ID subnet Data"
  type        = string
}

variable "subnet_private_id" {
  description = "ID subnet privé (requis par AWS pour le subnet group)"
  type        = string
}

variable "sg_data_id" {
  description = "ID SG Data"
  type        = string
}

variable "db_username" {
  description = "Nom utilisateur MySQL"
  type        = string
  default     = "ymmo_admin"
  sensitive   = true
}

variable "db_password" {
  description = "Mot de passe MySQL"
  type        = string
  sensitive   = true  # ne sera jamais affiché dans les logs Terraform
}
