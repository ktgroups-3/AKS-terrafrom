variable "prefix" {
  default = "demo"
}

variable "appId" {
}

variable "password" {
}

provider "azurerm" {
  version = "~> 1.27.0"
}

resource "azurerm_resource_group" "default" {
  name     = "${var.prefix}-rg"
  location = "West US 2"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${var.prefix}-k8s"

  agent_pool_profile {
    name            = "default"
    count           = 2
    vm_size         = "Standard_D2_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}

# Kubernetes provider
# provider "kubernetes" {
#   load_config_file = "false"

#   host                   = "${azurerm_kubernetes_cluster.main.kube_config.0.host}"
#   username               = "${azurerm_kubernetes_cluster.main.kube_config.0.username}"
#   password               = "${azurerm_kubernetes_cluster.main.kube_config.0.password}"
#   client_certificate     = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)}"
#   client_key             = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_key)}"
#   cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)}"
# }