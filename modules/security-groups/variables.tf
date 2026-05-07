variable "vpc_id" {
  description = "ID du VPC siège"
  type        = string
}

variable "subnet_private_cidr" {
  description = "CIDR subnet privé"
  type        = string
  default     = "10.0.10.0/24"
}

variable "admin_ips" {
  description = "IPs admins autorisées sur le bastion"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # ⚠️ remplace par ta vraie IP
}

variable "agences_cidrs" {
  description = "CIDRs des 12 agences"
  type        = list(string)
  default = [
    "10.1.0.0/16",  "10.2.0.0/16",  "10.3.0.0/16",
    "10.4.0.0/16",  "10.5.0.0/16",  "10.6.0.0/16",
    "10.7.0.0/16",  "10.8.0.0/16",  "10.9.0.0/16",
    "10.10.0.0/16", "10.11.0.0/16", "10.12.0.0/16",
  ]
}
