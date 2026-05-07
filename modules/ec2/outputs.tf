output "bastion_public_ip" {
  description = "IP publique du Bastion (pour s'y connecter)"
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "IP privée Bastion"
  value       = aws_instance.bastion.private_ip
}

output "srv_app_private_ip" {
  description = "IP privée SRV-APP01"
  value       = aws_instance.srv_app.private_ip
}

output "srv_dc_private_ip" {
  description = "IP privée SRV-DC01"
  value       = aws_instance.srv_dc.private_ip
}

output "srv_app_id" {
  description = "ID instance SRV-APP01 (utilisé par Ansible)"
  value       = aws_instance.srv_app.id
}

output "srv_dc_id" {
  description = "ID instance SRV-DC01 (utilisé par Ansible)"
  value       = aws_instance.srv_dc.id
}
