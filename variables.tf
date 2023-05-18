# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}
variable "aks_name" {
  description = "Azure Kubernetes Service Cluster name "
}

variable "rg_name" {
  description = "Azure Kubernetes Service Cluster name "
}
