# ================================================
# MODULE : VPN Site-to-Site — Ymmo
# Crée un tunnel IPsec IKEv2 entre le siège
# et une agence. Appelé 12 fois (une par agence)
# ================================================

# --- Virtual Private Gateway (côté siège) ---
# Passerelle VPN attachée au VPC siège
resource "aws_vpn_gateway" "siege" {
  vpc_id = var.vpc_siege_id

  tags = {
    Name    = "vgw-ymmo-siege"
    Project = "ymmo"
  }
}

# --- Customer Gateway (côté agence) ---
# Représente la gateway de l'agence côté AWS
resource "aws_customer_gateway" "agence" {
  bgp_asn    = 65000
  ip_address = var.agence_public_ip
  type       = "ipsec.1"

  tags = {
    Name    = "cgw-ymmo-agence-${var.agence_num}"
    Project = "ymmo"
  }
}

# --- Tunnel VPN Site-to-Site ---
resource "aws_vpn_connection" "siege_agence" {
  vpn_gateway_id      = aws_vpn_gateway.siege.id
  customer_gateway_id = aws_customer_gateway.agence.id
  type                = "ipsec.1"

  # Chiffrement AES-256 + SHA-256 comme défini dans les specs
  tunnel1_ike_versions                 = ["ikev2"]
  tunnel1_phase1_encryption_algorithms = ["AES256"]
  tunnel1_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase2_encryption_algorithms = ["AES256"]
  tunnel1_phase2_integrity_algorithms  = ["SHA2-256"]

  tunnel2_ike_versions                 = ["ikev2"]
  tunnel2_phase1_encryption_algorithms = ["AES256"]
  tunnel2_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase2_encryption_algorithms = ["AES256"]
  tunnel2_phase2_integrity_algorithms  = ["SHA2-256"]

  # Dead Peer Detection — surveillance tunnel
  tunnel1_dpd_timeout_action = "restart"
  tunnel2_dpd_timeout_action = "restart"

  static_routes_only = true

  tags = {
    Name    = "vpn-ymmo-siege-agence-${var.agence_num}"
    Project = "ymmo"
  }
}

# --- Route statique VPN → CIDR agence ---
# Permet au siège de joindre le réseau de l'agence
resource "aws_vpn_connection_route" "agence" {
  destination_cidr_block = var.agence_cidr
  vpn_connection_id      = aws_vpn_connection.siege_agence.id
}

# --- Route dans la table de routage privé du siège ---
# Pour que le subnet privé siège puisse joindre l'agence
resource "aws_route" "siege_vers_agence" {
  route_table_id         = var.route_table_private_id
  destination_cidr_block = var.agence_cidr
  gateway_id             = aws_vpn_gateway.siege.id
}

# --- Propagation des routes VPN ---
resource "aws_vpn_gateway_route_propagation" "siege" {
  vpn_gateway_id = aws_vpn_gateway.siege.id
  route_table_id = var.route_table_private_id
}
