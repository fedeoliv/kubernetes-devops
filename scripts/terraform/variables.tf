variable "client_id" {
    default = ""
}
variable "client_secret" {
    default = ""
}
variable "tenant_id" {
    default = ""
}
variable "rbac_server_app_id" {
    default = ""
}
variable "rbac_server_app_secret" {
    default = ""
}
variable "rbac_client_app_id" {
    default = ""
}

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
