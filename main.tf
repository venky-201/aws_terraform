resource "azurerm_resource_group" "this" {
  name = "conatinerapp"
  location = "eastus"
}
resource "azurerm_log_analytics_workspace" "example" {
  name                = "acctest-01"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
resource "azurerm_container_app_environment" "example" {
  name                       = "Example-Environment"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}
resource "azurerm_container_app" "this" {
  name = "eampleapp"
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name = azurerm_resource_group.this.name
  revision_mode = "single"
  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/k8se/quickstart:latest" # this test image
      // if we are using custom images using acr using store image no need mention any secrts only need mention identity any other artifacrtires needs fetach images needs provide secrts// 
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}
// if using gets scets from valt check redme.md file