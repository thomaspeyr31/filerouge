output "rds_endpoint" {
  description = "Endpoint RDS (utilisé par SRV-APP01 pour se connecter)"
  value       = aws_db_instance.ymmo.endpoint
}

output "rds_port" {
  description = "Port MySQL"
  value       = aws_db_instance.ymmo.port
}

output "rds_db_name" {
  description = "Nom de la base de données"
  value       = aws_db_instance.ymmo.db_name
}
