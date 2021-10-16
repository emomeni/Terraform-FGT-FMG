resource "fortios_logfortianalyzer_setting" "faz" {
  status                   = "enable"
  server                   = var.faz_ip
  certificate_verification = "disable"
}