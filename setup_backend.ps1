# Setup Terraform Backend for State Storage
$RESOURCE_GROUP_NAME = "rg-terraform-state"
$STORAGE_ACCOUNT_NAME = "tfstate" + (Get-Random -Minimum 10000 -Maximum 99999)
$CONTAINER_NAME = "tfstate"
$LOCATION = "brazilsouth"
$SUBSCRIPTION_ID = "a98fede1-1e42-4751-961c-8b6aacdc3589"

# Login if needed (assumes already logged in)
# az login

# Set Subscription
az account set --subscription $SUBSCRIPTION_ID

# Create Resource Group
Write-Host "Creating Resource Group $RESOURCE_GROUP_NAME..."
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create Storage Account
Write-Host "Creating Storage Account $STORAGE_ACCOUNT_NAME..."
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create Blob Container
Write-Host "Creating Blob Container $CONTAINER_NAME..."
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# Get Storage Account Key
$ACCOUNT_KEY = $(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

Write-Host "--------------------------------------------------"
Write-Host "Backend Setup Complete!"
Write-Host "Resource Group: $RESOURCE_GROUP_NAME"
Write-Host "Storage Account: $STORAGE_ACCOUNT_NAME"
Write-Host "Container Name: $CONTAINER_NAME"
Write-Host "Access Key: $ACCOUNT_KEY"
Write-Host "--------------------------------------------------"
Write-Host "Run the following command to initialize Terraform:"
Write-Host "terraform init -backend-config=`"resource_group_name=$RESOURCE_GROUP_NAME`" -backend-config=`"storage_account_name=$STORAGE_ACCOUNT_NAME`" -backend-config=`"container_name=$CONTAINER_NAME`" -backend-config=`"key=homolog.terraform.tfstate`""
