terraform {
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
    }
  }
}

provider "fortios" {
  hostname = var.management
  token    = var.token
  insecure = "true"
}

module "advpn_hub" {
  source = "../modules/advpn_hub"

  hostname    = "Hub2"
  loopback_ip = "172.28.255.201 255.255.255.255"
  wan1_ip     = "198.51.100.201 255.255.255.0"
  wan2_ip     = "192.88.99.201 255.255.255.0"
  port3_ip    = "172.28.0.5 255.255.255.252"
  vpn1 = {
    prefix        = "192.168.98.0 255.255.255.0"
    ip            = "192.168.98.253 255.255.255.255"
    remote_ip     = "192.168.98.254 255.255.255.0"
    ipv4_start_ip = "192.168.98.1"
    ipv4_end_ip   = "192.168.98.252"
    ipv4_netmask  = "255.255.255.0"
    network_id    = "1"
    aspath        = "65000"
  }
  vpn2 = {
    prefix        = "192.168.97.0 255.255.255.0"
    ip            = "192.168.97.253 255.255.255.255"
    remote_ip     = "192.168.97.254 255.255.255.0"
    ipv4_start_ip = "192.168.97.1"
    ipv4_end_ip   = "192.168.97.252"
    ipv4_netmask  = "255.255.255.0"
    network_id    = "2"
    aspath        = "65000 65000"
  }
  bgp = {
    neighbor        = "172.28.0.6"
    neighbor_range1 = "192.168.98.0 255.255.255.0"
    neighbor_range2 = "192.168.97.0 255.255.255.0"
  }
  faz_ip = "10.6.20.157"
  fmg_ip = "10.6.20.156"
}

