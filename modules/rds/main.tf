# ================================================
# MODULE : RDS MySQL — Ymmo
# Base de données centrale — subnet Data isolé
# Accessible uniquement depuis SRV-APP01 (SG-APP)
# ================================================

# Subnet group — RDS doit connaître les subnets où se déployer
resource "aws_db_subnet_group" "ymmo" {
  name       = "ymmo-rds-subnet-group"
  subnet_ids = [var.subnet_data_id, var.subnet_private_id]

  tags = {
    Name    = "ymmo-rds-subnet-group"
    Project = "ymmo"
  }
}

# --- RDS MySQL ---
resource "aws_db_instance" "ymmo" {
  identifier        = "ymmo-rds"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "ymmo"
  username = var.db_username
  password = var.db_password

  # Réseau
  db_subnet_group_name   = aws_db_subnet_group.ymmo.name
  vpc_security_group_ids = [var.sg_data_id]
  publicly_accessible    = false  # jamais exposé sur internet

  # Sauvegarde automatique — 30 jours comme prévu dans les specs
  backup_retention_period = 30
  backup_window           = "03:00-04:00"  # 3h du matin

  # Maintenance
  maintenance_window          = "Mon:04:00-Mon:05:00"
  auto_minor_version_upgrade  = true

  # Protection suppression accidentelle
  deletion_protection = false  # mettre true en production
  skip_final_snapshot = true   # mettre false en production

  tags = {
    Name    = "ymmo-rds-mysql"
    Project = "ymmo"
  }
}
