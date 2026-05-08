# ================================================
# MODULE : EC2 — Ymmo
# Crée 3 instances :
#   - Bastion-01  : point d'entrée SSH/RDP
#   - SRV-APP01   : serveur applicatif Ubuntu
#   - SRV-DC01    : contrôleur de domaine Windows
# ================================================

# --- Clé SSH (pour accès Bastion + SRV-APP01) ---
resource "aws_key_pair" "ymmo" {
  key_name   = "ymmo-key"
  public_key = file(var.ssh_public_key_path)

  tags = {
    Name    = "ymmo-key"
    Project = "ymmo"
  }
}

# --- Bastion-01 (10.0.1.10) ---
resource "aws_instance" "bastion" {
  ami                         = var.ami_ubuntu
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_public_id
  vpc_security_group_ids      = [var.sg_bastion_id]
  key_name                    = aws_key_pair.ymmo.key_name
  associate_public_ip_address = true


  tags = {
    Name    = "Bastion-01"
    Project = "ymmo"
    Role    = "bastion"
  }
}

# --- SRV-APP01 (10.0.10.20) ---
# Serveur applicatif Linux Ubuntu — API + Frontend
resource "aws_instance" "srv_app" {
  ami                         = var.ami_ubuntu
  instance_type               = "t3.small"
  subnet_id                   = var.subnet_private_id
  vpc_security_group_ids      = [var.sg_app_id]
  key_name                    = aws_key_pair.ymmo.key_name
  associate_public_ip_address = false


  # Script de démarrage — installe les dépendances de base
  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y git curl wget nginx
    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = {
    Name    = "SRV-APP01"
    Project = "ymmo"
    Role    = "app"
  }
}

# --- SRV-DC01 (10.0.10.10) ---
# Contrôleur de domaine Windows Server
resource "aws_instance" "srv_dc" {
  ami                         = var.ami_windows
  instance_type               = "t3.medium"  # Windows nécessite plus de RAM
  subnet_id                   = var.subnet_private_id
  vpc_security_group_ids      = [var.sg_dc_id]
  key_name                    = aws_key_pair.ymmo.key_name
  associate_public_ip_address = false


  # Script de démarrage Windows (PowerShell)
  user_data = <<-EOF
    <powershell>
    # Installation du rôle AD-DS
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
    # Promotion en contrôleur de domaine (Ansible prend le relais ensuite)
    </powershell>
  EOF

  tags = {
    Name    = "SRV-DC01"
    Project = "ymmo"
    Role    = "domain-controller"
  }
}
