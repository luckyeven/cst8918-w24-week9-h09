provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "app" {
  name     = "AKSResourceGroup"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "app" {
  name                = "AKSCluster"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  sku_tier = "Free"


}
output "kube_config" {
value     = azurerm_kubernetes_cluster.app.kube_config_raw
sensitive = true
}