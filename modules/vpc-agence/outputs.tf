output "vpc_id" {
  description = "ID VPC agence"
  value       = aws_vpc.agence.id
}

output "subnet_public_id" {
  description = "ID subnet public agence"
  value       = aws_subnet.public.id
}

output "subnet_private_id" {
  description = "ID subnet privé agence"
  value       = aws_subnet.private.id
}

output "nat_gateway_id" {
  description = "ID NAT Gateway agence"
  value       = aws_nat_gateway.agence.id
}

output "vpc_cidr" {
  description = "CIDR du VPC agence (utilisé par le module VPN)"
  value       = aws_vpc.agence.id
}
