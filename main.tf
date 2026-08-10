##-----------------------------------------------------------------------------
## Azure Private Endpoint
##-----------------------------------------------------------------------------

module "labels" {
  source          = "terraform-az-modules/tags/azurerm"
  version         = "1.0.2"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

resource "azurerm_private_endpoint" "main" {
  name                          = local.private_endpoint_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = local.network_interface_name
  edge_zone                     = var.edge_zone
  tags                          = module.labels.tags

  dynamic "ip_configuration" {
    for_each = var.ip_configurations

    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      member_name        = ip_configuration.value.member_name
      subresource_name   = ip_configuration.value.subresource_name
    }
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group == null ? [] : [var.private_dns_zone_group]

    content {
      name                 = local.private_dns_zone_group_name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  private_service_connection {
    name                              = local.private_service_connection_name
    is_manual_connection              = var.private_service_connection.is_manual_connection
    private_connection_resource_id    = var.private_service_connection.private_connection_resource_id
    private_connection_resource_alias = var.private_service_connection.private_connection_resource_alias
    request_message                   = var.private_service_connection.request_message
    subresource_names                 = var.private_service_connection.subresource_names
  }

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  lifecycle {
    precondition {
      condition = (
        (var.private_service_connection.private_connection_resource_id != null) !=
        (var.private_service_connection.private_connection_resource_alias != null)
      )
      error_message = "Set exactly one of private_connection_resource_id or private_connection_resource_alias."
    }
  }
}

moved {
  from = azurerm_private_endpoint.private_endpoint
  to   = azurerm_private_endpoint.main
}
