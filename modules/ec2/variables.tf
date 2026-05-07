variable "ami_ubuntu" {
  description = "AMI Ubuntu 22.04 LTS"
  type        = string
  default     = "ami-04df1508c6be5879e"  # eu-west-3 (Paris)
}

variable "ami_windows" {
  description = "AMI Windows Server 2022"
  type        = string
  default     = "ami-0a7c031f74651ad62"  # Windows Server 2022 eu-west-3
}

variable "subnet_public_id" {
  description = "ID subnet public (Bastion)"
  type        = string
}

variable "subnet_private_id" {
  description = "ID subnet privé (SRV-APP01, SRV-DC01)"
  type        = string
}

variable "sg_bastion_id" {
  description = "ID SG Bastion"
  type        = string
}

variable "sg_app_id" {
  description = "ID SG Application"
  type        = string
}

variable "sg_dc_id" {
  description = "ID SG Controleur de domaine"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Chemin vers ta clé SSH publique"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
