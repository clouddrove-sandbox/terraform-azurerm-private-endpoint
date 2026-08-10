##-----------------------------------------------------------------------------
## Locals
##-----------------------------------------------------------------------------

locals {
  name = var.custom_name != null ? var.custom_name : module.labels.id

  private_endpoint_name = var.resource_position_prefix ? format("pe-%s", local.name) : format("%s-pe", local.name)
  network_interface_name = coalesce(
    var.custom_network_interface_name,
    var.resource_position_prefix ? format("nic-%s", local.private_endpoint_name) : format("%s-nic", local.private_endpoint_name)
  )
  private_service_connection_name = coalesce(
    var.private_service_connection.name,
    var.resource_position_prefix ? format("psc-%s", local.name) : format("%s-psc", local.name)
  )
  private_dns_zone_group_name = var.private_dns_zone_group == null ? null : coalesce(
    var.private_dns_zone_group.name,
    var.resource_position_prefix ? format("dns-zone-group-%s", local.name) : format("%s-dns-zone-group", local.name)
  )

  private_dns_zone_ids = var.private_dns_zone_group == null ? [] : var.private_dns_zone_group.private_dns_zone_ids
}
