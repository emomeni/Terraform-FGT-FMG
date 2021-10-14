resource "fortios_firewall_policy" "HealthCheck" {
  action     = "accept"
  logtraffic = "all"
  name       = "HealthCheck"
  policyid   = 1
  schedule   = "always"

  dstaddr {
    name = "all"
  }

  dstintf {
    name = fortios_system_interface.lo0.name
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = "all"
  }

  srcintf {
    name = "virtual-wan-link"
  }
  depends_on = [
    fortios_system_interface.lo0,
    fortios_system_sdwan.sdwan
  ]
}

resource "fortios_firewall_policy" "Branch_to_DC" {
  action                  = "accept"
  logtraffic              = "all"
  name                    = "Branch_to_DC"
  policyid                = 2
  schedule                = "always"
  tcp_session_without_syn = "eanble"

  dstaddr {
    name = "all"
  }

  dstintf {
    name = fortios_system_interface.port3.name
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = "all"
  }

  srcintf {
    name = "virtual-wan-link"
  }
  depends_on = [
    fortios_system_interface.port3,
    fortios_system_sdwan.sdwan
  ]
}

resource "fortios_firewall_policy" "DC_to_Branch" {
  action     = "accept"
  logtraffic = "all"
  name       = "DC_to_Branch"
  policyid   = 3
  schedule   = "always"

  dstaddr {
    name = "all"
  }

  dstintf {
    name = "virtual-wan-link"
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = "all"
  }

  srcintf {
    name = fortios_system_interface.port3.name
  }
  depends_on = [
    fortios_system_interface.port3,
    fortios_system_sdwan.sdwan
  ]
}

resource "fortios_firewall_policy" "DC_Internet" {
  action     = "accept"
  logtraffic = "all"
  name       = "DC_Internet"
  policyid   = 4
  schedule   = "always"
  nat        = "enable"

  dstaddr {
    name = "all"
  }

  dstintf {
    name = fortios_system_interface.WAN1.name
  }

  dstintf {
    name = fortios_system_interface.WAN2.name
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = "all"
  }

  srcintf {
    name = fortios_system_interface.port3.name
  }
  depends_on = [
    fortios_system_interface.port3,
    fortios_system_interface.WAN1,
    fortios_system_interface.WAN2,
    fortios_system_sdwan.sdwan
  ]
}

resource "fortios_firewall_policy" "Branch_to_Branch" {
  action            = "accept"
  logtraffic        = "all"
  name              = "Branch_to_Branch"
  policyid          = 5
  schedule          = "always"
  application_list  = "default"
  ssl_ssh_profile   = "certificate-inspection"
  utm_status        = "enable"
  webfilter_profile = "monitor-all"


  dstaddr {
    name = "all"
  }

  dstintf {
    name = "virtual-wan-link"
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = "all"
  }

  srcintf {
    name = "virtual-wan-link"
  }
  depends_on = [
    fortios_system_sdwan.sdwan
  ]
}