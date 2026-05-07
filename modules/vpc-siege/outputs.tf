output "vpc_id" {
  description = "ID du VPC siège"
  value       = aws_vpc.siege.id
}

output "subnet_public_id" {
  description = "ID subnet public"
  value       = aws_subnet.public.id
}

output "subnet_private_id" {
  description = "ID subnet privé"
  value       = aws_subnet.private.id
}

output "subnet_data_id" {
  description = "ID subnet data"
  value       = aws_subnet.data.id
}

output "igw_id" {
  description = "ID Internet Gateway"
  value       = aws_internet_gateway.siege.id
}

output "nat_gateway_id" {
  description = "ID NAT Gateway"
  value       = aws_nat_gateway.siege.id
}

output "route_table_private_id" {
  description = "ID route table subnet privé"
  value       = aws_route_table.private.id
}
