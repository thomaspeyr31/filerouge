output "sg_bastion_id" {
  value = aws_security_group.bastion.id
}

output "sg_app_id" {
  value = aws_security_group.app.id
}

output "sg_dc_id" {
  value = aws_security_group.dc.id
}

output "sg_poste_id" {
  value = aws_security_group.poste.id
}

output "sg_data_id" {
  value = aws_security_group.data.id
}
