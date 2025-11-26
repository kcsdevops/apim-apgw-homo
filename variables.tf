variable "environment" {
  description = "Environment suffix (e.g., homolog, dev, prod)"
  type        = string
  default     = "homolog"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "brazilsouth"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-meurrh-360-pnt-br-apgw-02-hom"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Project     = "MeuRH360"
    Environment = "Homologacao"
    ManagedBy   = "Terraform"
  }
}
