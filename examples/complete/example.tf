provider "azurerm" {
  features {}
}

resource "random_string" "storage_suffix" {
  length  = 6
  special = false
  upper   = false
}

locals {
  base_name    = lower(join("-", compact([var.name, var.environment])))
  compact_name = lower(join("", regexall("[0-9A-Za-z]", local.base_name)))

  resource_group_name  = var.resource_position_prefix ? format("rg-%s", local.base_name) : format("%s-rg", local.base_name)
  virtual_network_name = var.resource_position_prefix ? format("vnet-%s", local.base_name) : format("%s-vnet", local.base_name)
  subnet_name          = var.resource_position_prefix ? format("snet-pe-%s", local.base_name) : format("%s-pe-snet", local.base_name)
  storage_account_name = substr(format("%sst%s", local.compact_name, random_string.storage_suffix.result), 0, 24)

  tags = merge({
    Environment    = var.environment
    ManagedBy      = "terraform"
    DeploymentMode = "terraform"
  }, var.extra_tags)
}

resource "azurerm_resource_group" "example" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "example" {
  name                = local.virtual_network_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = var.virtual_network_address_space
  tags                = local.tags
}

resource "azurerm_subnet" "private_endpoints" {
  name                              = local.subnet_name
  resource_group_name               = azurerm_resource_group.example.name
  virtual_network_name              = azurerm_virtual_network.example.name
  address_prefixes                  = var.private_endpoint_subnet_address_prefixes
  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_storage_account" "example" {
  name                          = local.storage_account_name
  resource_group_name           = azurerm_resource_group.example.name
  location                      = azurerm_resource_group.example.location
  account_tier                  = var.storage_account_tier
  account_replication_type      = var.storage_account_replication_type
  account_kind                  = "StorageV2"
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false
  shared_access_key_enabled     = false
  tags                          = local.tags
}

resource "azurerm_private_dns_zone" "storage_blob" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.example.name
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_blob" {
  name                  = var.resource_position_prefix ? format("vnet-link-%s", local.base_name) : format("%s-vnet-link", local.base_name)
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_blob.name
  virtual_network_id    = azurerm_virtual_network.example.id
  registration_enabled  = false
  tags                  = local.tags
}

module "private_endpoint" {
  source = "../../"

  name                     = var.name
  environment              = var.environment
  location                 = azurerm_resource_group.example.location
  resource_position_prefix = var.resource_position_prefix
  resource_group_name      = azurerm_resource_group.example.name
  subnet_id                = azurerm_subnet.private_endpoints.id
  label_order              = var.label_order
  repository               = var.repository
  managedby                = var.managedby
  deployment_mode          = var.deployment_mode
  extra_tags               = var.extra_tags

  private_service_connection = {
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = ["blob"]
  }

  ip_configurations = var.private_ip_address == null ? [] : [{
    name               = "blob"
    private_ip_address = var.private_ip_address
    member_name        = "blob"
    subresource_name   = "blob"
  }]

  private_dns_zone_group = {
    private_dns_zone_ids = [azurerm_private_dns_zone.storage_blob.id]
  }

  timeouts = var.timeouts

  depends_on = [azurerm_private_dns_zone_virtual_network_link.storage_blob]
}
