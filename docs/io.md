# Inputs and outputs

## Required inputs

| Name | Type | Description |
|---|---|---|
| `name` | `string` | Base workload or application name. |
| `location` | `string` | Azure region. |
| `resource_group_name` | `string` | Existing resource group name. |
| `subnet_id` | `string` | Existing subnet ID. |
| `private_service_connection` | `object` | Connection settings and exactly one target resource ID or alias. |

## Optional inputs

| Name | Default | Description |
|---|---|---|
| `resource_position_prefix` | `false` | Put resource tokens before instead of after the base name. |
| `custom_name` | `null` | Override the generated base label. |
| `environment` | `""` | Deployment environment included in names and tags. |
| `label_order` | `["name", "environment", "location"]` | Base-name component order. |
| `repository` | `""` | Repository tag value. |
| `managedby` | `""` | Managedby tag value. |
| `deployment_mode` | `"terraform"` | Deployment mode tag value. |
| `extra_tags` | `{}` | Additional tags merged with generated tags. |
| `custom_network_interface_name` | `null` | Custom endpoint NIC name. |
| `edge_zone` | `null` | Azure Edge Zone. |
| `ip_configurations` | `[]` | Static IP, member, and subresource settings. |
| `private_dns_zone_group` | `null` | Group name and existing Private DNS zone IDs. |
| `timeouts` | `null` | Create, read, update, and delete timeouts. |

The `private_service_connection` object supports:

- `name` (optional; generated when omitted)
- `private_connection_resource_id`
- `private_connection_resource_alias`
- `is_manual_connection`
- `request_message`
- `subresource_names`

Set exactly one of `private_connection_resource_id` and `private_connection_resource_alias`.

The Private Endpoint, NIC, service connection, and DNS group names use the same prefix/suffix resource-token convention as the Service Bus module.

## Outputs

The module exports `id`, `name`, `resource`, `private_ip_address`, `network_interface`, `private_service_connection`, `custom_dns_configs`, `private_dns_zone_configs`, and `private_dns_zone_ids`.
