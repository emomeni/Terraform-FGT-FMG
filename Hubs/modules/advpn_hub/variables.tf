variable "hostname" {
  description = "FortiGate system hostname"
  type        = string
}

variable "loopback_ip" {
  description = "Loopback (lo0) interface IP address"
  type        = string
}

variable "wan1_ip" {
  description = "WAN1 interface IP address"
  type        = string
}

variable "wan2_ip" {
  description = "WAN2 interface IP address"
  type        = string
}

variable "port3_ip" {
  description = "port3 interface IP address"
  type        = string
}

variable "vpn1" {
  description = "VPN1 specific parameters"
  type = object({
    prefix        = string
    ip            = string
    remote_ip     = string
    ipv4_start_ip = string
    ipv4_end_ip   = string
    ipv4_netmask  = string
    network_id    = string
    aspath        = string
  })
}

variable "vpn2" {
  description = "VPN2 specific parameters"
  type = object({
    prefix        = string
    ip            = string
    remote_ip     = string
    ipv4_start_ip = string
    ipv4_end_ip   = string
    ipv4_netmask  = string
    network_id    = string
    aspath        = string
  })
}

variable "bgp" {
  type = object({
    neighbor        = string
    neighbor_range1 = string
    neighbor_range2 = string
  })
}

variable "faz_ip" {
  description = "local FAZ IP address"
  type = string
}

variable "fmg_ip" {
  description = "local FMG IP address"
  type = string
}