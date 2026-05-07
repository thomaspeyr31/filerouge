# ================================================
# MODULE : VPC Siège — Ymmo
# Crée le VPC principal avec 3 subnets :
#   - Public  : 10.0.1.0/24  (IGW, NAT-GW, Bastion)
#   - Privé   : 10.0.10.0/24 (SRV-DC01, SRV-APP01)
#   - Data    : 10.0.20.0/24 (RDS MySQL, S3)
# ================================================

resource "aws_vpc" "siege" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "vpc-ymmo-siege"
    Project = "ymmo"
    Site    = "siege"
  }
}

resource "aws_internet_gateway" "siege" {
  vpc_id = aws_vpc.siege.id

  tags = {
    Name    = "igw-ymmo-siege"
    Project = "ymmo"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.siege.id
  cidr_block              = var.subnet_public_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name    = "subnet-ymmo-siege-public"
    Project = "ymmo"
    Type    = "public"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.siege.id
  cidr_block        = var.subnet_private_cidr
  availability_zone = var.az

  tags = {
    Name    = "subnet-ymmo-siege-prive"
    Project = "ymmo"
    Type    = "private"
  }
}

resource "aws_subnet" "data" {
  vpc_id            = aws_vpc.siege.id
  cidr_block        = var.subnet_data_cidr
  availability_zone = var.az

  tags = {
    Name    = "subnet-ymmo-siege-data"
    Project = "ymmo"
    Type    = "data"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name    = "eip-ymmo-nat-siege"
    Project = "ymmo"
  }
}

resource "aws_nat_gateway" "siege" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name    = "nat-gw-ymmo-siege"
    Project = "ymmo"
  }

  depends_on = [aws_internet_gateway.siege]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.siege.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.siege.id
  }

  tags = {
    Name    = "rt-ymmo-siege-public"
    Project = "ymmo"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.siege.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.siege.id
  }

  tags = {
    Name    = "rt-ymmo-siege-prive"
    Project = "ymmo"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table" "data" {
  vpc_id = aws_vpc.siege.id

  tags = {
    Name    = "rt-ymmo-siege-data"
    Project = "ymmo"
  }
}

resource "aws_route_table_association" "data" {
  subnet_id      = aws_subnet.data.id
  route_table_id = aws_route_table.data.id
}
