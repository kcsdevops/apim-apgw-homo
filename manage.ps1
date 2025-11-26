param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("setup", "init", "plan", "apply", "destroy", "fmt", "validate", "cost", "help")]
    [string]$Command,

    [string]$StorageAccountName,

    [string]$Currency = "BRL"
)

$ErrorActionPreference = "Stop"

# Configurações do Backend
$ResourceGroupName = "rg-terraform-state"
$ContainerName = "tfstate"
$Key = "homolog.terraform.tfstate"

function Show-Help {
    Write-Host "Comandos disponíveis:"
    Write-Host "  .\manage.ps1 -Command setup    - Executa o script de configuração do backend"
    Write-Host "  .\manage.ps1 -Command init     - Inicializa o Terraform (Requer -StorageAccountName)"
    Write-Host "  .\manage.ps1 -Command plan     - Planeja as mudanças"
    Write-Host "  .\manage.ps1 -Command apply    - Aplica as mudanças"
    Write-Host "  .\manage.ps1 -Command destroy  - Destrói a infraestrutura"
    Write-Host "  .\manage.ps1 -Command fmt      - Formata os arquivos .tf"
    Write-Host "  .\manage.ps1 -Command validate - Valida a configuração"
    Write-Host "  .\manage.ps1 -Command cost     - Gera estimativa de custos (Infracost)"
}

switch ($Command) {
    "help" {
        Show-Help
    }
    "setup" {
        ./setup_backend.ps1
    }
    "init" {
        if ([string]::IsNullOrEmpty($StorageAccountName)) {
            Write-Error "O parâmetro -StorageAccountName é obrigatório para o comando 'init'."
        }
        terraform init `
            -backend-config="resource_group_name=$ResourceGroupName" `
            -backend-config="storage_account_name=$StorageAccountName" `
            -backend-config="container_name=$ContainerName" `
            -backend-config="key=$Key"
    }
    "plan" {
        terraform plan
    }
    "apply" {
        terraform apply -auto-approve
    }
    "destroy" {
        terraform destroy -auto-approve
    }
    "fmt" {
        terraform fmt -recursive
    }
    "validate" {
        terraform validate
    }$env:INFRACOST_CURRENCY = $Currency
        
    "cost" {
        infracost breakdown --path .
    }
}
