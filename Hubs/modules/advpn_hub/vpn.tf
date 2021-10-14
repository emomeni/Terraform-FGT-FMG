resource "fortios_vpnipsec_phase1interface" "VPN1_P1" {
  add_route             = "disable"
  auto_discovery_sender = "enable"
  dpd                   = "on-idle"
  dpd_retryinterval     = "60"
  ike_version           = "2"
  interface             = "WAN1"
  ipv4_end_ip           = var.vpn1.ipv4_end_ip
  ipv4_netmask          = var.vpn1.ipv4_netmask
  ipv4_start_ip         = var.vpn1.ipv4_start_ip
  mode_cfg              = "enable"
  name                  = "VPN1"
  net_device            = "disable"
  peertype              = "any"
  psksecret             = "fortinet"
  proposal              = "aes256-sha256"
  network_overlay       = "enable"
  network_id            = var.vpn1.network_id
  type                  = "dynamic"
  fec_ingress           = "enable"
  fec_egress            = "enable"
  depends_on            = [fortios_system_interface.WAN1]
}

resource "fortios_vpnipsec_phase2interface" "VPN1_P2" {
  phase1name = fortios_vpnipsec_phase1interface.VPN1_P1.name
  proposal   = "aes256-sha256"
  name       = "VPN1"
  depends_on = [fortios_vpnipsec_phase1interface.VPN1_P1]
}

resource "fortios_vpnipsec_phase1interface" "VPN2_P1" {
  add_route             = "disable"
  auto_discovery_sender = "enable"
  dpd                   = "on-idle"
  dpd_retryinterval     = "60"
  ike_version           = "2"
  interface             = "WAN2"
  ipv4_end_ip           = var.vpn2.ipv4_end_ip
  ipv4_netmask          = var.vpn2.ipv4_netmask
  ipv4_start_ip         = var.vpn2.ipv4_start_ip
  mode_cfg              = "enable"
  name                  = "VPN2"
  net_device            = "disable"
  peertype              = "any"
  psksecret             = "fortinet"
  proposal              = "aes256-sha256"
  network_overlay       = "enable"
  network_id            = var.vpn2.network_id
  type                  = "dynamic"
  fec_ingress           = "enable"
  fec_egress            = "enable"
  depends_on            = [fortios_system_interface.WAN2]
}

resource "fortios_vpnipsec_phase2interface" "VPN2_P2" {
  phase1name = fortios_vpnipsec_phase1interface.VPN2_P1.name
  proposal   = "aes256-sha256"
  name       = "VPN2"
  depends_on = [fortios_vpnipsec_phase1interface.VPN2_P1]
}
