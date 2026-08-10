output "private_endpoint_id" {
  description = "Private Endpoint ID."
  value       = module.private_endpoint.id
}

output "private_endpoint_ip_address" {
  description = "Private Endpoint IP address."
  value       = module.private_endpoint.private_ip_address
}
