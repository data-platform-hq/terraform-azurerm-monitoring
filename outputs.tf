output "workbook_adf_id" {
  value       = [for k, v in var.adf_map : azurerm_application_insights_workbook.adf[k].id]
  description = "Azure Workbook ADF Template ID"
}

output "workbook_databricks_id" {
  value       = [for k, v in var.log_analytics_workspace_map : azurerm_application_insights_workbook.databricks[k].id]
  description = "Azure Workbook Databricks Template ID"
}

output "dashboard_adf_id" {
  value       = [for k, v in var.adf_map : azurerm_portal_dashboard.adf[k].id]
  description = "Azure Shared Dashboard Adf ID"
}

output "dashboard_databricks_id" {
  value       = [for k, v in var.log_analytics_workspace_map : azurerm_portal_dashboard.databricks[k].id]
  description = "Azure Shared Dashboard Databricks ID"
}
