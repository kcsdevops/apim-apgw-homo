variable "resource_group_name" {
  description = "Nome do grupo de recursos"
}
variable "location" {
  description = "Localização dos recursos"
}
variable "tags" {
  description = "Tags para os recursos"
}
variable "environment" {
  description = "Ambiente de implantação"
}
variable "subnet_id" {
  description = "ID da subnet onde o Application Gateway será provisionado"
}
variable "apim_hostname" {
  description = "Hostname do API Management para o Backend Pool"
  type        = string
  default     = "" # Opcional por enquanto para não quebrar se não passado
}
