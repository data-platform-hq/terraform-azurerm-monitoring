variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace is created"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "adf_map" {
  type        = map(string)
  description = "Azure Data Factory name to id map"
}

variable "log_analytics_workspace_map" {
  type        = map(string)
  description = "Azure Log Analytics name to id map"
}
