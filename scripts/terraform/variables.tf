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

variable "kubernetes_version" {
    default = "1.11.4"
}

variable "agent_count" {
    default = 1
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "azadk8s2"
}

variable cluster_name {
    default = "azadk8s2"
}

variable resource_group_name {
    default = "azure-ad-k8s2-rg"
}

variable location {
    default = "West Europe"
}
