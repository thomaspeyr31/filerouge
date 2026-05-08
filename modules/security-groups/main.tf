# ================================================
# MODULE : Security Groups - Ymmo
# ================================================

resource "aws_security_group" "bastion" {
  name        = "ymmo-bastion"
  description = "Bastion - acces SSH/RDP administrateurs"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.admin_ips
  }

  ingress {
    description = "RDP admin"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.admin_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ymmo-bastion"
    Project = "ymmo"
  }
}

resource "aws_security_group" "app" {
  name        = "ymmo-app"
  description = "SRV-APP01 - HTTPS public, SSH depuis bastion"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS public"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP redirection"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "SSH depuis bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description = "HTTPS agences VPN"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.agences_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ymmo-app"
    Project = "ymmo"
  }
}

resource "aws_security_group" "dc" {
  name        = "ymmo-dc"
  description = "SRV-DC01 - AD/DNS/DHCP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.subnet_private_cidr]
  }
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [var.subnet_private_cidr]
  }
  ingress {
    from_port   = 88
    to_port     = 88
    protocol    = "tcp"
    cidr_blocks = [var.subnet_private_cidr]
  }
  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = [var.subnet_private_cidr]
  }
  ingress {
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = [var.subnet_private_cidr]
  }
  ingress {
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = [var.subnet_private_cidr]
  }
  ingress {
    description     = "RDP depuis bastion"
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = var.agences_cidrs
  }
  ingress {
    from_port   = 88
    to_port     = 88
    protocol    = "tcp"
    cidr_blocks = var.agences_cidrs
  }
  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = var.agences_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ymmo-dc"
    Project = "ymmo"
  }
}

resource "aws_security_group" "poste" {
  name        = "ymmo-poste"
  description = "Postes Windows - RDP depuis bastion uniquement"
  vpc_id      = var.vpc_id

  ingress {
    description     = "RDP depuis bastion"
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ymmo-poste"
    Project = "ymmo"
  }
}

resource "aws_security_group" "data" {
  name        = "ymmo-data"
  description = "RDS MySQL - acces SG-APP uniquement"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL depuis SG-APP"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.subnet_private_cidr]
  }

  tags = {
    Name    = "ymmo-data"
    Project = "ymmo"
  }
}
