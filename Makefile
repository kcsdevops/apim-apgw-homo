# Makefile para gerenciamento do Terraform

# Variáveis de configuração do Backend
RESOURCE_GROUP_NAME = rg-terraform-state
CONTAINER_NAME = tfstate
KEY = homolog.terraform.tfstate
# ATENÇÃO: Substitua o valor abaixo pelo nome da sua storage account gerada pelo script setup_backend.ps1
# Você pode passar via linha de comando: make init STORAGE_ACCOUNT_NAME=tfstate12345
STORAGE_ACCOUNT_NAME ?= <NOME_DA_SUA_STORAGE_ACCOUNT>

.PHONY: help setup init plan apply destroy fmt validate cost

help:
	@echo "Comandos disponíveis:"
	@echo "  make setup    - Executa o script de configuração do backend"
	@echo "  make init     - Inicializa o Terraform (Requer STORAGE_ACCOUNT_NAME)"
	@echo "  make plan     - Planeja as mudanças"
	@echo "  make apply    - Aplica as mudanças"
	@echo "  make destroy  - Destrói a infraestrutura"
	@echo "  make fmt      - Formata os arquivos .tf"
	@echo "  make validate - Valida a configuração"
	@echo "  make cost     - Gera estimativa de custos (Infracost)"

setup:
	pwsh ./setup_backend.ps1

init:
	terraform init \
		-backend-config="resource_group_name=$(RESOURCE_GROUP_NAME)" \
		-backend-config="storage_account_name=$(STORAGE_ACCOUNT_NAME)" \
		-backend-config="container_name=$(CONTAINER_NAME)" \
		-backend-config="key=$(KEY)"

plan:
	terraform plan

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

fmt:
	terraform fmt -recursive

validate:
	terraform validate

cost:
	infracost breakdown --path .
