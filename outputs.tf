output "bastion_public_ip" {
  description = "IP publique du Bastion — point d'entrée SSH/RDP"
  value       = module.ec2.bastion_public_ip
}

output "srv_app_private_ip" {
  description = "IP privée SRV-APP01"
  value       = module.ec2.srv_app_private_ip
}

output "srv_dc_private_ip" {
  description = "IP privée SRV-DC01"
  value       = module.ec2.srv_dc_private_ip
}

output "rds_endpoint" {
  description = "Endpoint RDS MySQL"
  value       = module.rds.rds_endpoint
}
