resource "fortios_firewall_policy" "allow-all" {
  action     = "accept"
  logtraffic = "all"
  name       = "allow-all"
  policyid   = 1
  schedule   = "always"

  dstaddr {
    name = "all"
  }

  dstintf {
    name = "any"
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = "all"
  }

  srcintf {
    name = "any"
  }
}