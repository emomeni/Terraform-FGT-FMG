terraform {
  required_providers {
    fortios = {
      # Reported bug - 752701
      #source = "fortinetdev/fortios"
      source = "fortios.billgrant.io/local/fortios"
    }
  }
}


