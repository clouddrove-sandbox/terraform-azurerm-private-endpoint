##-----------------------------------------------------------------------------
## Variables
##-----------------------------------------------------------------------------

##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------

variable "resource_position_prefix" {
  description = "If true, puts resource type tokens before the generated name instead of after it."
  type        = bool
  default     = false
}

variable "custom_name" {
  description = "Optional custom base name that overrides the generated label ID."
  type        = string
  default     = null
}

variable "label_order" {
  description = "Order used to construct the base name. Supported labels are name, environment, and location."
  type        = list(string)
  default     = ["name", "environment", "location"]
}

variable "name" {
  description = "Base workload or application name."
  type        = string
}

variable "environment" {
  description = "Deployment environment, such as dev, staging, or prod."
  type        = string
  default     = ""
}

variable "repository" {
  description = "Repository associated with the deployment."
  type        = string
  default     = ""
}

variable "managedby" {
  description = "Value for the generated Managedby tag."
  type        = string
  default     = ""
}

variable "deployment_mode" {
  description = "How the infrastructure is deployed."
  type        = string
  default     = "terraform"
}

variable "extra_tags" {
  description = "Additional tags merged with the standard generated tags."
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "Azure region where the Private Endpoint will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the Private Endpoint will be created."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet in which the Private Endpoint will be created."
  type        = string
}

variable "custom_network_interface_name" {
  description = "Optional custom name for the network interface created for the Private Endpoint."
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "Optional Edge Zone where the Private Endpoint will be created."
  type        = string
  default     = null
}

variable "private_service_connection" {
  description = "Private service connection. Set exactly one resource ID or Private Link Service alias."
  type = object({
    name                              = optional(string)
    private_connection_resource_id    = optional(string)
    private_connection_resource_alias = optional(string)
    is_manual_connection              = optional(bool, false)
    request_message                   = optional(string)
    subresource_names                 = optional(list(string))
  })
}

variable "ip_configurations" {
  description = "Optional static IP configurations for the Private Endpoint."
  type = list(object({
    name               = string
    private_ip_address = string
    member_name        = optional(string)
    subresource_name   = optional(string)
  }))
  default = []
}

variable "private_dns_zone_group" {
  description = "Optional Private DNS zone group. Supply IDs of existing azurerm_private_dns_zone resources."
  type = object({
    name                 = optional(string)
    private_dns_zone_ids = list(string)
  })
  default = null
}

variable "timeouts" {
  description = "Optional create, read, update, and delete timeout overrides."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
