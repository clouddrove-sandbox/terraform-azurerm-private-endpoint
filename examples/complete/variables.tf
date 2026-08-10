variable "name" {
  description = "Base workload name used for all example resources."
  type        = string
  default     = "privateendpoint"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "test"
}

variable "location" {
  description = "Azure region in which to deploy the example."
  type        = string
  default     = "centralindia"
}

variable "resource_position_prefix" {
  description = "Whether resource type tokens are placed before generated names."
  type        = bool
  default     = true
}

variable "label_order" {
  description = "Label order passed to the Private Endpoint module."
  type        = list(string)
  default     = ["name", "environment", "location"]
}

variable "repository" {
  description = "Repository tag passed to the Private Endpoint module."
  type        = string
  default     = ""
}

variable "managedby" {
  description = "ManagedBy tag passed to the Private Endpoint module."
  type        = string
  default     = "terraform"
}

variable "deployment_mode" {
  description = "Deployment mode tag passed to the Private Endpoint module."
  type        = string
  default     = "terraform"
}

variable "extra_tags" {
  description = "Additional tags applied to the example resources."
  type        = map(string)
  default     = {}
}

variable "virtual_network_address_space" {
  description = "Address space for the example virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "private_endpoint_subnet_address_prefixes" {
  description = "Address prefixes for the Private Endpoint subnet."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "private_ip_address" {
  description = "Optional static Private Endpoint IP address. Null lets Azure allocate it dynamically."
  type        = string
  default     = null
}

variable "private_dns_zone_name" {
  description = "Private DNS zone used by the Storage Blob Private Endpoint."
  type        = string
  default     = "privatelink.blob.core.windows.net"
}

variable "storage_account_tier" {
  description = "Performance tier for the test Storage Account."
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Replication type for the test Storage Account."
  type        = string
  default     = "LRS"
}

variable "timeouts" {
  description = "Optional Private Endpoint operation timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
