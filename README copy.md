# Terraform Azure Private Endpoint

A small Terraform module for Azure Private Endpoints. It uses only the official [`hashicorp/azurerm`](https://registry.terraform.io/providers/hashicorp/azurerm/latest) provider.

## Features

- Azure resource ID or Private Link Service alias connections
- Automatic or manual connection approval
- One or more target subresources
- Dynamic or static private IP addresses
- Existing Private DNS zone association
- Custom network interface name
- Edge Zone support
- Tags and resource timeout overrides
- Endpoint, IP, NIC, connection, and DNS outputs
- Service Bus-style generated names and standard tags

This module intentionally creates only the Private Endpoint. Create resource groups, subnets, target resources, and Private DNS zones separately with official AzureRM resources, then pass their IDs to this module.

## Requirements

| Name | Version |
|---|---|
| Terraform | >= 1.10.0 |
| hashicorp/azurerm | >= 4.0, < 5.0 |
| terraform-az-modules/tags/azurerm | 1.0.2 |

## Naming

The base name follows the Service Bus module's default label order:

```text
<name>-<environment>-<location-short>
```

With `name = "storage"`, `environment = "dev"`, and `location = "centralindia"`, suffix mode (the default) produces:

- Private Endpoint: `storage-dev-inci-pe`
- Network interface: `storage-dev-inci-pe-nic`
- Service connection: `storage-dev-inci-psc`
- DNS zone group: `storage-dev-inci-dns-zone-group`

Set `resource_position_prefix = true` to put the resource tokens first. Explicit optional names override their generated value.

## Basic usage

```hcl
module "private_endpoint" {
  source = "terraform-az-modules/privateendpoint/azurerm"

  name                = "storage"
  environment         = "dev"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.private_endpoints.id

  private_service_connection = {
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group = {
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }

  tags = {
    environment = "dev"
  }
}
```

See [`examples/basic`](./examples/basic) and [`examples/complete`](./examples/complete). The full interface is documented in [`docs/io.md`](./docs/io.md).

## License

Apache 2.0. See [LICENSE](./LICENSE).
