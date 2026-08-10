mock_provider "azurerm" {}

variables {
  name                = "storage"
  environment         = "test"
  location            = "centralindia"
  resource_group_name = "rg-example-test-cin"
  subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example-test-cin/providers/Microsoft.Network/virtualNetworks/vnet-example/subnets/snet-private-endpoints"

  private_service_connection = {
    private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example-test-cin/providers/Microsoft.Storage/storageAccounts/ste0001"
    subresource_names              = ["blob"]
  }

  private_dns_zone_group = {
    private_dns_zone_ids = [
      "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example-test-cin/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    ]
  }
}

run "validate_module" {
  command = plan

  assert {
    condition     = azurerm_private_endpoint.main.name == "storage-test-inci-pe"
    error_message = "The Private Endpoint should use the standard generated suffix name."
  }

  assert {
    condition     = azurerm_private_endpoint.main.custom_network_interface_name == "storage-test-inci-pe-nic"
    error_message = "The NIC should use the standard generated suffix name."
  }
}

run "validate_prefix_names" {
  command = plan

  variables {
    resource_position_prefix = true
  }

  assert {
    condition     = azurerm_private_endpoint.main.name == "pe-storage-test-inci"
    error_message = "The Private Endpoint should use the standard generated prefix name."
  }

  assert {
    condition     = azurerm_private_endpoint.main.custom_network_interface_name == "nic-pe-storage-test-inci"
    error_message = "The NIC should use the standard generated prefix name."
  }

  assert {
    condition     = local.private_service_connection_name == "psc-storage-test-inci"
    error_message = "The service connection should use the standard generated prefix name."
  }

  assert {
    condition     = local.private_dns_zone_group_name == "dns-zone-group-storage-test-inci"
    error_message = "The DNS zone group should use the standard generated prefix name."
  }
}
