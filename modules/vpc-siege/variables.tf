variable "vpc_cidr" {
  description = "CIDR du VPC siège"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_public_cidr" {
  description = "CIDR subnet public"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_private_cidr" {
  description = "CIDR subnet privé"
  type        = string
  default     = "10.0.10.0/24"
}

variable "subnet_data_cidr" {
  description = "CIDR subnet data"
  type        = string
  default     = "10.0.20.0/24"
}

variable "az" {
  description = "Availability Zone AWS"
  type        = string
  default     = "eu-west-3a"  # Paris
}
