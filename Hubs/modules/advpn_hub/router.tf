resource "fortios_router_static" "Hub1_ISP1" {
  device     = "WAN1"
  distance   = 10
  dst        = "0.0.0.0 0.0.0.0"
  gateway    = "198.51.100.254"
  seq_num    = 1
  status     = "enable"
  depends_on = [fortios_system_interface.WAN1]
}

resource "fortios_router_static" "Hub1_ISP2" {
  device     = "WAN2"
  distance   = 10
  dst        = "0.0.0.0 0.0.0.0"
  gateway    = "192.88.99.254"
  seq_num    = 2
  status     = "enable"
  depends_on = [fortios_system_interface.WAN2]
}

resource "fortios_router_policy" "Policy1" {
  input_device {
    name = "VPN1"
  }
  srcaddr {
    name = "all"
  }
  dstaddr {
    name = "all"
  }
  output_device = "VPN1"
  depends_on    = [fortios_system_interface.VPN1]
}

resource "fortios_router_policy" "Policy2" {
  input_device {
    name = "VPN2"
  }
  srcaddr {
    name = "all"
  }
  dstaddr {
    name = "all"
  }
  output_device = "VPN2"
  depends_on    = [fortios_system_interface.VPN2]
}

resource "fortios_router_accesslist" "VPN1" {
  name = "VPN1"
  rule {
    prefix = var.vpn1.prefix
  }
}

resource "fortios_router_accesslist" "VPN2" {
  name = "VPN2"
  rule {
    prefix = var.vpn2.prefix
  }
}

resource "fortios_router_accesslist" "datacenter" {
  name = "datacenter"
  rule {
    prefix = "172.28.254.0 255.255.255.0"
  }
}

resource "fortios_router_communitylist" "one" {
  name = "65000:1"
  type = "standard"

  rule {
    id     = 1
    action = "permit"
    match  = "65000:1"
  }
}

resource "fortios_router_communitylist" "two" {
  name = "65000:2"
  type = "standard"

  rule {
    id     = 1
    action = "permit"
    match  = "65000:2"
  }
}

resource "fortios_router_communitylist" "five" {
  name = "65000:5"
  type = "standard"

  rule {
    id     = 1
    action = "permit"
    match  = "65000:5"
  }
}

resource "fortios_router_routemap" "VPN1" {
  name = "VPN1-RouteMap"

  rule {
    id               = 1
    match_ip_nexthop = "VPN1"
  }

  rule {
    id               = 2
    match_ip_address = "datacenter"
  }
  depends_on = [fortios_router_accesslist.VPN1, fortios_router_accesslist.datacenter]
}

resource "fortios_router_routemap" "VPN2" {
  name = "VPN2-RouteMap"

  rule {
    id               = 1
    match_ip_nexthop = "VPN2"
  }

  rule {
    id               = 2
    match_ip_address = "datacenter"
  }
  depends_on = [fortios_router_accesslist.VPN2, fortios_router_accesslist.datacenter]
}

resource "fortios_router_routemap" "VPN1_IN" {
  name = "VPN1-RouteMap_IN"

  rule {
    id              = 1
    match_community = "65000:1"
    set_route_tag   = 1
  }

  rule {
    id              = 2
    match_community = "65000:2"
    set_route_tag   = 2
  }

  rule {
    id              = 3
    match_community = "65000:5"
    set_route_tag   = 11
    set_aspath {
      as = var.vpn1.aspath
    }
  }
  depends_on = [
    fortios_router_communitylist.one,
    fortios_router_communitylist.two,
    fortios_router_communitylist.five
  ]
}

resource "fortios_router_routemap" "VPN2_IN" {
  name = "VPN2-RouteMap_IN"

  rule {
    id              = 1
    match_community = "65000:1"
    set_route_tag   = 1
  }

  rule {
    id              = 2
    match_community = "65000:2"
    set_route_tag   = 2
  }

  rule {
    id              = 3
    match_community = "65000:5"
    set_route_tag   = 11
    set_aspath {
      as = var.vpn2.aspath
    }
  }
  depends_on = [
    fortios_router_communitylist.one,
    fortios_router_communitylist.two,
    fortios_router_communitylist.five
  ]
}

resource "fortios_router_bgp" "bgp" {
  as                     = "65000"
  router_id              = element(split(" ", fortios_system_interface.lo0.ip), 0)
  ibgp_multipath         = "enable"
  additional_path        = "enable"
  graceful_restart       = "enable"
  additional_path_select = "4"
  neighbor {
    ip                   = var.bgp.neighbor
    soft_reconfiguration = "enable"
    remote_as            = "64999"
  }
  neighbor_group {
    name                        = fortios_vpnipsec_phase1interface.VPN1_P1.name
    soft_reconfiguration        = "enable"
    capability_graceful_restart = "enable"
    link_down_failover          = "enable"
    remote_as                   = 65000
    additional_path             = "send"
    route_reflector_client      = "enable"
    next_hop_self               = "enable"
    route_map_in                = fortios_router_routemap.VPN1_IN.name
  }
  neighbor_group {
    name                        = fortios_vpnipsec_phase1interface.VPN2_P1.name
    soft_reconfiguration        = "enable"
    capability_graceful_restart = "enable"
    link_down_failover          = "enable"
    remote_as                   = 65000
    additional_path             = "send"
    route_reflector_client      = "enable"
    next_hop_self               = "enable"
    route_map_in                = fortios_router_routemap.VPN2_IN.name
  }
  depends_on = [
    fortios_system_interface.lo0,
    fortios_vpnipsec_phase1interface.VPN1_P1,
    fortios_router_routemap.VPN1_IN,
    fortios_vpnipsec_phase1interface.VPN2_P1,
    fortios_router_routemap.VPN2_IN,
    fortios_router_communitylist.one,
    fortios_router_communitylist.two,
    fortios_router_communitylist.five,
  ]
}

# Reported bug - 0752830	
resource "fortios_router_bgp" "neighbor_range" {
  as                     = "65000"
  router_id              = element(split(" ", fortios_system_interface.lo0.ip), 0)
  ibgp_multipath         = "enable"
  additional_path        = "enable"
  graceful_restart       = "enable"
  additional_path_select = "4"
  neighbor_range {
    id             = "1"
    prefix         = var.bgp.neighbor_range1
    neighbor_group = fortios_vpnipsec_phase1interface.VPN1_P1.name
  }
  neighbor_range {
    id             = "2"
    prefix         = var.bgp.neighbor_range2
    neighbor_group = fortios_vpnipsec_phase1interface.VPN2_P1.name
  }
  depends_on = [fortios_router_bgp.bgp]

}