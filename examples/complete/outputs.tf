output "resource_group_name" {
  description = "Name of the resource group created for the example."
  value       = azurerm_resource_group.example.name
}

output "virtual_network_id" {
  description = "ID of the virtual network created for the example."
  value       = azurerm_virtual_network.example.id
}

output "subnet_id" {
  description = "ID of the Private Endpoint subnet."
  value       = azurerm_subnet.private_endpoints.id
}

output "target_resource_id" {
  description = "ID of the Storage Account targeted by the Private Endpoint."
  value       = azurerm_storage_account.example.id
}

output "private_dns_zone_id" {
  description = "ID of the Private DNS zone associated with the endpoint."
  value       = azurerm_private_dns_zone.storage_blob.id
}

output "private_endpoint_id" {
  description = "ID of the created Private Endpoint."
  value       = module.private_endpoint.id
}

output "private_endpoint_name" {
  description = "Generated name of the Private Endpoint."
  value       = module.private_endpoint.name
}

output "private_endpoint_ip_address" {
  description = "Private IP address assigned to the endpoint."
  value       = module.private_endpoint.private_ip_address
}

output "network_interface" {
  description = "Network interface created for the Private Endpoint."
  value       = module.private_endpoint.network_interface
}

output "private_dns_zone_configs" {
  description = "Private DNS zone configurations reported by the endpoint."
  value       = module.private_endpoint.private_dns_zone_configs
}
