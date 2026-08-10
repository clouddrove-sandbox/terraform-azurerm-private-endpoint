##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------

output "id" {
  description = "ID of the Private Endpoint."
  value       = azurerm_private_endpoint.main.id
}

output "name" {
  description = "Name of the Private Endpoint."
  value       = azurerm_private_endpoint.main.name
}

output "network_interface_name" {
  description = "Generated or overridden name of the Private Endpoint network interface."
  value       = local.network_interface_name
}

output "private_service_connection_name" {
  description = "Generated or overridden name of the private service connection."
  value       = local.private_service_connection_name
}

output "private_dns_zone_group_name" {
  description = "Generated or overridden Private DNS zone group name."
  value       = local.private_dns_zone_group_name
}

output "tags" {
  description = "Standard and additional tags applied to the Private Endpoint."
  value       = module.labels.tags
}

output "resource" {
  description = "Private Endpoint resource object."
  value       = azurerm_private_endpoint.main
  sensitive   = true
}

output "private_ip_address" {
  description = "Primary private IP address assigned to the Private Endpoint."
  value       = try(azurerm_private_endpoint.main.private_service_connection[0].private_ip_address, null)
}

output "network_interface" {
  description = "Network interface created for the Private Endpoint."
  value       = azurerm_private_endpoint.main.network_interface
}

output "private_service_connection" {
  description = "Private service connection attributes."
  value       = azurerm_private_endpoint.main.private_service_connection
  sensitive   = true
}

output "custom_dns_configs" {
  description = "Custom DNS configurations reported by the Private Endpoint."
  value       = azurerm_private_endpoint.main.custom_dns_configs
}

output "private_dns_zone_configs" {
  description = "Private DNS zone configurations reported by the Private Endpoint."
  value       = azurerm_private_endpoint.main.private_dns_zone_configs
}

output "private_dns_zone_ids" {
  description = "Private DNS zone IDs associated through the DNS zone group."
  value       = local.private_dns_zone_ids
}
