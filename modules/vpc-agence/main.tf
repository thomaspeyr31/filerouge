# ================================================
# MODULE : VPC Agence — Ymmo
# Utilisé 12 fois (une instance par agence)
# Remplacer N par le numéro de l'agence (1 à 12)
# ================================================

resource "aws_vpc" "agence" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "vpc-ymmo-agence-${var.agence_num}"
    Project = "ymmo"
    Site    = "agence-${var.agence_num}"
  }
}

# --- Internet Gateway agence ---
resource "aws_internet_gateway" "agence" {
  vpc_id = aws_vpc.agence.id

  tags = {
    Name    = "igw-ymmo-agence-${var.agence_num}"
    Project = "ymmo"
  }
}

# --- Subnet Public agence ---
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.agence.id
  cidr_block              = var.subnet_public_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name    = "subnet-ymmo-agence-${var.agence_num}-public"
    Project = "ymmo"
    Type    = "public"
  }
}

# --- Subnet Privé agence ---
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.agence.id
  cidr_block        = var.subnet_private_cidr
  availability_zone = var.az

  tags = {
    Name    = "subnet-ymmo-agence-${var.agence_num}-prive"
    Project = "ymmo"
    Type    = "private"
  }
}

# --- Elastic IP NAT agence ---
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name    = "eip-ymmo-agence-${var.agence_num}"
    Project = "ymmo"
  }
}

# --- NAT Gateway agence ---
resource "aws_nat_gateway" "agence" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name    = "nat-gw-ymmo-agence-${var.agence_num}"
    Project = "ymmo"
  }

  depends_on = [aws_internet_gateway.agence]
}

# --- Route table public → IGW ---
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.agence.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.agence.id
  }

  tags = {
    Name    = "rt-ymmo-agence-${var.agence_num}-public"
    Project = "ymmo"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# --- Route table privé → NAT + VPN vers siège ---
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.agence.id

  # Sortie internet via NAT
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.agence.id
  }

  # Route vers le siège via VPN (ajoutée par le module VPN)
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = var.vpn_gateway_id
  }

  tags = {
    Name    = "rt-ymmo-agence-${var.agence_num}-prive"
    Project = "ymmo"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
