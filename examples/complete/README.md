# Complete Private Endpoint example

This deployable example creates all prerequisites needed to test the root module:

- Resource group
- Virtual network and dedicated Private Endpoint subnet
- Storage Account as the Private Link target
- Blob Private DNS zone and VNet link
- Private Endpoint through the root module

No subscription IDs or Azure resource IDs are hardcoded. Terraform connects resources through their exported attributes, and a random suffix makes the Storage Account name globally unique.

## Run the example

Authenticate to Azure using your organization's normal method, then run:

```bash
cd examples/complete
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

Customize `terraform.tfvars` for the target environment. At minimum, review the Azure region, network ranges, and tags. Set `private_ip_address` to an unused address inside `private_endpoint_subnet_address_prefixes` to test static IP configuration; leave it `null` to test dynamic allocation.

Destroy the test resources when finished:

```bash
terraform destroy
```
