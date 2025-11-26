# Configuração do Backend Terraform para Armazenamento de Estado
$RESOURCE_GROUP_NAME = "rg-terraform-state"
$STORAGE_ACCOUNT_NAME = "tfstate" + (Get-Random -Minimum 10000 -Maximum 99999)
$CONTAINER_NAME = "tfstate"
$LOCATION = "brazilsouth"
$SUBSCRIPTION_ID = "a98fede1-1e42-4751-961c-8b6aacdc3589"

# Login se necessário (assume que já está logado)
# az login

# Definir Assinatura
az account set --subscription $SUBSCRIPTION_ID

# Criar Grupo de Recursos
Write-Host "Criando Grupo de Recursos $RESOURCE_GROUP_NAME..."
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Criar Conta de Armazenamento
Write-Host "Criando Conta de Armazenamento $STORAGE_ACCOUNT_NAME..."
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Criar Container de Blob
Write-Host "Criando Container de Blob $CONTAINER_NAME..."
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# Obter Chave da Conta de Armazenamento
$ACCOUNT_KEY = $(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

Write-Host "--------------------------------------------------"
Write-Host "Configuração do Backend Concluída!"
Write-Host "Grupo de Recursos: $RESOURCE_GROUP_NAME"
Write-Host "Conta de Armazenamento: $STORAGE_ACCOUNT_NAME"
Write-Host "Nome do Container: $CONTAINER_NAME"
Write-Host "Chave de Acesso: $ACCOUNT_KEY"
Write-Host "--------------------------------------------------"
Write-Host "Execute o seguinte comando para inicializar o Terraform:"
Write-Host "terraform init -backend-config=`"resource_group_name=$RESOURCE_GROUP_NAME`" -backend-config=`"storage_account_name=$STORAGE_ACCOUNT_NAME`" -backend-config=`"container_name=$CONTAINER_NAME`" -backend-config=`"key=homolog.terraform.tfstate`""
