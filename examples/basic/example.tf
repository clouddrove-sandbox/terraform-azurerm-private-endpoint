provider "azurerm" {
  features {}
}

module "private_endpoint" {
  source = "../../"

  name                = "storage"
  environment         = "dev"
  location            = "centralindia"
  resource_group_name = "rg-example-dev-cin"
  subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example-dev-cin/providers/Microsoft.Network/virtualNetworks/vnet-example/subnets/snet-private-endpoints"

  private_service_connection = {
    private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example-dev-cin/providers/Microsoft.Storage/storageAccounts/ste0001"
    subresource_names              = ["blob"]
  }
}
