output "vpn_connection_id" {
  description = "ID tunnel VPN"
  value       = aws_vpn_connection.siege_agence.id
}

output "vpn_gateway_id" {
  description = "ID Virtual Private Gateway (utilisé par vpc-agence)"
  value       = aws_vpn_gateway.siege.id
}

output "tunnel1_address" {
  description = "IP publique tunnel 1"
  value       = aws_vpn_connection.siege_agence.tunnel1_address
}

output "tunnel2_address" {
  description = "IP publique tunnel 2 (redondance)"
  value       = aws_vpn_connection.siege_agence.tunnel2_address
}
