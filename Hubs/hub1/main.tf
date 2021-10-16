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

  hostname    = "Hub1"
  loopback_ip = "172.28.255.200 255.255.255.255"
  wan1_ip     = "198.51.100.200 255.255.255.0"
  wan2_ip     = "192.88.99.200 255.255.255.0"
  port3_ip    = "172.28.0.1 255.255.255.252"
  vpn1 = {
    prefix        = "192.168.100.0 255.255.255.0"
    ip            = "192.168.100.253 255.255.255.255"
    remote_ip     = "192.168.100.254 255.255.255.0"
    ipv4_start_ip = "192.168.100.1"
    ipv4_end_ip   = "192.168.100.252"
    ipv4_netmask  = "255.255.255.0"
    network_id    = "1"
    aspath        = "65000"
  }
  vpn2 = {
    prefix        = "192.168.99.0 255.255.255.0"
    ip            = "192.168.99.253 255.255.255.255"
    remote_ip     = "192.168.99.254 255.255.255.0"
    ipv4_start_ip = "192.168.99.1"
    ipv4_end_ip   = "192.168.99.252"
    ipv4_netmask  = "255.255.255.0"
    network_id    = "2"
    aspath        = "65000 65000"
  }
  bgp = {
    neighbor        = "172.28.0.2"
    neighbor_range1 = "192.168.100.0 255.255.255.0"
    neighbor_range2 = "192.168.99.0 255.255.255.0"
  }
  faz_ip = "10.6.20.157"
  fmg_ip = "10.6.20.156"
}

