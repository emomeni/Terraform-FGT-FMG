resource "fortios_system_interface" "lo0" {
  ip          = "172.28.255.253 255.255.255.255"
  allowaccess = "ping https ssh snmp http telnet fgfm radius-acct probe-response fabric ftm speed-test"
  name        = "lo0"
  role        = "lan"
  type        = "loopback"
  vdom        = "root"
  mode        = "static"
  status      = "up"
}

resource "fortios_system_interface" "port1" {
  name                  = "port1"
  ip                    = "172.28.0.2 255.255.255.252"
  status                = "up"
  device_identification = "enable"
  speed                 = "auto"
  role                  = "lan"
  allowaccess           = "ping"
  mode                  = "static"
  type                  = "physical"
  vdom                  = "root"
  alias                 = "To-Hub1"
}

resource "fortios_system_interface" "port2" {
  name                  = "port2"
  ip                    = "172.28.0.6 255.255.255.252"
  status                = "up"
  device_identification = "enable"
  speed                 = "auto"
  role                  = "lan"
  allowaccess           = "ping"
  mode                  = "static"
  type                  = "physical"
  vdom                  = "root"
  alias                 = "To-Hub2"
}

resource "fortios_system_interface" "port3" {
  name                  = "port3"
  ip                    = "172.28.254.1 255.255.255.0"
  status                = "up"
  device_identification = "enable"
  speed                 = "auto"
  role                  = "lan"
  allowaccess           = "ping"
  mode                  = "static"
  type                  = "physical"
  vdom                  = "root"
  alias                 = "LAN"
}