variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "project_name" { type = string }
variable "environment" { type = string }
variable "gateway_subnet_id" { type = string }
variable "onprem_public_ip" { type = string }
variable "onprem_local_networks" { type = list(string) }
variable "vpn_shared_key" { type = string }