

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.aks_name
  location            = "West US"
  resource_group_name = var.rg_name #"svcloudtech"
  dns_prefix          = var.aks_name

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }


  tags = {
    environment = "Demo"
  }
}
