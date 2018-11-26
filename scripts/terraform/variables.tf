variable "workspace_to_environment_map" {
    description = "A set of known environments (workspaces)"
    type = "map"
    default = {
        dev     = "dev"
        tst     = "tst"
        staging = "stg"
        prod    = "prod"
    }
}

variable resource_group_name {
    description = "Resource group name"
    type = "map"
    default = {
        dev     = "rg-contoso-dev"
        tst     = "rg-contoso-tst"
        staging = "rg-contoso-stg"
        prod    = "rg-contoso"
    }
}

variable location {
    default = "East US"
}

# Kubernetes
variable k8s_cluster_name {
    description = "Kubernetes cluster name"
    type = "map"
    default = {
        dev     = "contosoclusterdev"
        tst     = "contosoclustertst"
        staging = "contosoclusterstg"
        prod    = "contosocluster"
    }
}
variable "k8s_version" {
    default = "1.11.4"
}

variable "k8s_agent_count" {
    description = "Number of Kubernetes nodes"
    type = "map"
    default = {
        dev     = 1
        tst     = 1
        staging = 3
        prod    = 3
    }
}

variable "k8s_vm_size" {
    description = "Kubernetes VM size"
    type = "map"
    default = {
        dev     = "Standard_B2s"
        tst     = "Standard_B2s"
        staging = "Standard_DS2_v2"
        prod    = "Standard_DS2_v2"
    }
}

variable "k8s_os_disk_size" {
    description = "Kubernetes OS disk size"
    type = "map"
    default = {
        dev     = 30
        tst     = 30
        staging = 30
        prod    = 30
    }
}

variable "k8s_ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "k8s_dns_prefix" {
    description = "Kubernetes DNS name prefix"
    type = "map"
    default = {
        dev     = "contosoclusterdev"
        tst     = "contosoclustertst"
        staging = "contosoclusterstg"
        prod    = "contosocluster"
    }
}

# Service Principal
data "azurerm_key_vault_secret" "sp_id_dev" {
  name      = "sp-id-dev"
  vault_uri = "https://<your_keyvault_name>.vault.azure.net/"
}
data "azurerm_key_vault_secret" "sp_secret_dev" {
  name      = "sp-secret-dev"
  vault_uri = "https://<your_keyvault_name>.vault.azure.net/"
}
data "azurerm_key_vault_secret" "sp_id_tst" {
  name      = "sp-id-tst"
  vault_uri = "https://<your_keyvault_name>.vault.azure.net/"
}
data "azurerm_key_vault_secret" "sp_secret_tst" {
  name      = "sp-secret-tst"
  vault_uri = "https://<your_keyvault_name>.vault.azure.net/"
}
data "azurerm_key_vault_secret" "sp_id_stg" {
  name      = "sp-id-stg"
  vault_uri = "https://<your_keyvault_name>.vault.azure.net/"
}
data "azurerm_key_vault_secret" "sp_secret_stg" {
  name      = "sp-secret-stg"
  vault_uri = "https://<your_keyvault_name>.vault.azure.net/"
}
data "azurerm_key_vault_secret" "sp_id_prod" {
  name      = "sp-id-prod"
  vault_uri = "https://<your_keyvault_name>.vault.azure.net/"
}
data "azurerm_key_vault_secret" "sp_secret_prod" {
  name      = "sp-secret-prod"
  vault_uri = "https://<your_keyvault_name>.vault.azure.net/"
}

# AKS RBAC
variable "tenant_id" {
    description = "Tenant ID used for AKS RBAC"
    default = ""
}
variable "rbac_server_app_id" {
    description = "AAD server app ID used for AKS RBAC"
    default = ""
}
variable "rbac_server_app_secret" {
    description = "AAD server app secret used for AKS RBAC"
    default = ""
}
variable "rbac_client_app_id" {
    description = "AAD client app ID used for AKS RBAC"
    default = ""
}






