#!/bin/bash

# Key Vault variables

KV_NAME=contosokvault

KV_SP_CLIENT_ID_DEV="sp-id-dev"
KV_SP_CLIENT_SECRET_DEV="sp-secret-dev"

KV_SP_CLIENT_ID_TST="sp-id-tst"
KV_SP_CLIENT_SECRET_TST="sp-secret-tst"

KV_SP_CLIENT_ID_STG="sp-id-stg"
KV_SP_CLIENT_SECRET_STG="sp-secret-stg"

KV_SP_CLIENT_ID_PROD="sp-id-prod"
KV_SP_CLIENT_SECRET_PROD="sp-secret-prod"

# Service Principal variables

SP_NAME_DEV="serviceprincipaldev"
SP_SECRET_DEV="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

SP_NAME_TST="serviceprincipaltst"
SP_SECRET_TST="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

SP_NAME_STG="serviceprincipalstg"
SP_SECRET_STG="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

SP_NAME_PROD="serviceprincipalprod"
SP_SECRET_PROD="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

# Create service principal for each environment

printf "\nCreating service principal for DEV environment...\n"
az ad sp create-for-rbac --name $SP_NAME_DEV --password $SP_SECRET_DEV

printf "\nCreating service principal for TST environment...\n"
az ad sp create-for-rbac --name $SP_NAME_TST --password $SP_SECRET_TST

printf "\nCreating service principal for STG environment...\n"
az ad sp create-for-rbac --name $SP_NAME_STG --password $SP_SECRET_STG

printf "\nCreating service principal for PROD environment...\n"
az ad sp create-for-rbac --name $SP_NAME_PROD --password $SP_SECRET_PROD

printf "\nStoring secrets to key vault...\n"

# Add client ID and client secrets to key vault
CLIENT_ID_DEV=$(az ad sp show --id http://$SP_NAME_DEV | jq -r '.appId')
az keyvault secret set --vault-name $KV_NAME --name $KV_SP_CLIENT_ID_DEV --value $CLIENT_ID_DEV
az keyvault secret set --vault-name $KV_NAME --name $KV_SP_CLIENT_SECRET_DEV --value $SP_SECRET_DEV

CLIENT_ID_TST=$(az ad sp show --id http://$SP_NAME_TST | jq -r '.appId')
az keyvault secret set --vault-name $KV_NAME --name $KV_SP_CLIENT_ID_TST --value $CLIENT_ID_TST
az keyvault secret set --vault-name $KV_NAME --name $KV_SP_CLIENT_SECRET_TST --value $SP_SECRET_TST

CLIENT_ID_STG=$(az ad sp show --id http://$SP_NAME_STG | jq -r '.appId')
az keyvault secret set --vault-name $KV_NAME --name $KV_SP_CLIENT_ID_STG --value $CLIENT_ID_STG
az keyvault secret set --vault-name $KV_NAME --name $KV_SP_CLIENT_SECRET_STG --value $SP_SECRET_STG

CLIENT_ID_PROD=$(az ad sp show --id http://$SP_NAME_PROD | jq -r '.appId')
az keyvault secret set --vault-name $KV_NAME --name $KV_SP_CLIENT_ID_PROD --value $CLIENT_ID_PROD
az keyvault secret set --vault-name $KV_NAME --name $KV_SP_CLIENT_SECRET_PROD --value $SP_SECRET_PROD

printf "\nDone!\n"
