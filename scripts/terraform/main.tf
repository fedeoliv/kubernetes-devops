provider "azurerm" {
    version = "~>1.19"
}

terraform {
    backend "azurerm" {}
}

locals {
    # If the Terraform workspace name does not exist in the map, it will default to dev
    environment = "${lookup(var.workspace_to_environment_map, terraform.workspace, "dev")}"
    client_id = {
        dev     = "${data.azurerm_key_vault_secret.sp_id_dev.value}"
        tst     = "${data.azurerm_key_vault_secret.sp_id_tst.value}"
        staging = "${data.azurerm_key_vault_secret.sp_id_stg.value}"
        prod    = "${data.azurerm_key_vault_secret.sp_id_prod.value}"
    }
    client_secret = {
        dev     = "${data.azurerm_key_vault_secret.sp_secret_dev.value}"
        tst     = "${data.azurerm_key_vault_secret.sp_secret_tst.value}"
        staging = "${data.azurerm_key_vault_secret.sp_secret_stg.value}"
        prod    = "${data.azurerm_key_vault_secret.sp_secret_prod.value}"
    }
}

resource "azurerm_resource_group" "k8s" {
    name     = "${var.resource_group_name[local.environment]}"
    location = "${var.location}"
}

resource "azurerm_storage_account" "registry_storage" {
    count                    = "${terraform.workspace == "prod" ? 1 : 0}"
    name                     = "${var.storage_account_name}"
    resource_group_name      = "${azurerm_resource_group.k8s.name}"
    location                 = "${azurerm_resource_group.k8s.location}"
    account_tier             = "Standard"
    account_replication_type = "GRS"
}

resource "azurerm_container_registry" "container_registry" {
    count               = "${terraform.workspace == "prod" ? 1 : 0}"
    name                = "${var.container_registry_name}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    location            = "${azurerm_resource_group.k8s.location}"
    admin_enabled       = true
    sku                 = "Classic"
    storage_account_id  = "${azurerm_storage_account.registry_storage.id}"
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "${var.k8s_cluster_name[local.environment]}"
    location            = "${azurerm_resource_group.k8s.location}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    dns_prefix          = "${var.k8s_dns_prefix[local.environment]}"
    kubernetes_version  = "${var.k8s_version}"


    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = "${file("${var.k8s_ssh_public_key}")}"
        }
    }

    agent_pool_profile {
        name            = "default"
        count           = "${var.k8s_agent_count[local.environment]}"
        vm_size         = "${var.k8s_vm_size[local.environment]}"
        os_type         = "Linux"
        os_disk_size_gb = "${var.k8s_os_disk_size[local.environment]}"
    }

    service_principal {
        client_id     = "${local.client_id[local.environment]}"
        client_secret = "${local.client_secret[local.environment]}"
    }

    tags {
        Environment = "${local.environment}"
    }

    role_based_access_control {
        azure_active_directory {
            server_app_id     = "${var.rbac_server_app_id}"
            server_app_secret = "${var.rbac_server_app_secret}"
            client_app_id     = "${var.rbac_client_app_id}"
            tenant_id         = "${var.tenant_id}"
        }
    }
}
