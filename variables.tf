variable "aws_region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-3"
}

variable "az" {
  description = "Availability Zone"
  type        = string
  default     = "eu-west-3a"
}

variable "ami_ubuntu" {
  description = "AMI Ubuntu 22.04 LTS — eu-west-3"
  type        = string
  default     = "ami-04df1508c6be5879e"
}

variable "ami_windows" {
  description = "AMI Windows Server 2022 — eu-west-3"
  type        = string
  default     = "ami-0a7c031f74651ad62"
}

variable "ssh_public_key_path" {
  description = "Chemin clé SSH publique"
  type        = string
  default     = "./keys/ymmo-key.pub"
}

variable "admin_ips" {
  description = "IPs admins autorisées sur le bastion"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_username" {
  description = "Utilisateur MySQL"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Mot de passe MySQL"
  type        = string
  sensitive   = true
}
