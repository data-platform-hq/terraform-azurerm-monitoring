output "workbook_adf_id" {
  value       = length(var.adf_id) == 0 ? "" : azurerm_application_insights_workbook.adf[0].id
  description = "Azure Workbook ADF Template ID"
}

output "workbook_databricks_id" {
  value       = length(var.adf_id) == 0 ? "" : azurerm_application_insights_workbook.databricks[0].id
  description = "Azure Workbook Databricks Template ID"
}

output "dashboard_adf_id" {
  value       = length(var.adf_id) == 0 ? "" : azurerm_portal_dashboard.adf[0].id
  description = "Azure Shared Dashboard ADF ID"
}

output "dashboard_databricks_id" {
  value       = length(var.log_analytics_workspace_id) == 0 ? "" : azurerm_portal_dashboard.databricks[0].id
  description = "Azure Shared Dashboard Databricks ID"
}
