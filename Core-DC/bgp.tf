resource "fortios_router_bgp" "bgp" {
  as               = "64999"
  ebgp_multipath   = "enable"
  router_id        = "172.28.255.252"
  graceful_restart = "enable"
  neighbor {
    ip                   = "172.28.0.1"
    remote_as            = "65000"
    soft_reconfiguration = "enable"
  }
  neighbor {
    ip                   = "172.28.0.5"
    remote_as            = "65000"
    soft_reconfiguration = "enable"
  }
  network {
    id     = "1"
    prefix = "172.28.254.0 255.255.255.0"
  }
}