variable "environment" {
  description = "Sufixo do ambiente (ex: homolog, dev, prod)"
  type        = string
  default     = "homolog"
}

variable "location" {
  description = "Região do Azure"
  type        = string
  default     = "brazilsouth"
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  type        = string
  default     = "rg-meurrh-360-pnt-br-apgw-02-hom"
}

variable "tags" {
  description = "Tags para aplicar aos recursos"
  type        = map(string)
  default = {
    Project     = "MeuRH360"
    Environment = "Homologacao"
    ManagedBy   = "Terraform"
  }
}
