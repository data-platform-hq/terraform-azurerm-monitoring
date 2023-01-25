output "workbook_adf_id" {
  value       = azurerm_application_insights_workbook.adf.id
  description = "Azure Workbook ADF Template ID"
}

output "workbook_databricks_id" {
  value       = azurerm_application_insights_workbook.databricks.id
  description = "Azure Workbook Databricks Template ID"
}

output "dashboard_adf_id" {
  value       = azurerm_portal_dashboard.adf.id
  description = "Azure Shared Dashboard ADF ID"
}

output "dashboard_databricks_id" {
  value       = azurerm_portal_dashboard.databricks.id
  description = "Azure Shared Dashboard Databricks ID"
}
