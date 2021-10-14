resource "fortios_system_global" "sysglobal" {
  hostname     = "Core-DC"
  timezone     = "12"
  admintimeout = "480"
}