#!/bin/bash

# Variables
RESOURCE_GROUP_NAME=tstate
STORAGE_ACCOUNT_NAME=tstate$RANDOM
CONTAINER_NAME=tstate
LOCATION=eastus

KV_NAME=<your_keyvault_name>
KV_SECRET_NAME=terraform-backend-key

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create key vault
az keyvault create --name $KV_NAME --resource-group $RESOURCE_GROUP_NAME --location $LOCATION

# Add account secret to key vault
az keyvault secret set --vault-name $KV_NAME --name $KV_SECRET_NAME --value $ACCOUNT_KEY

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
