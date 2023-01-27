/*
output "workbook_adf_id" {
  value       = length(var.adf_id) == 0 ? "" : azurerm_application_insights_workbook.adf[each.key].id
  description = "Azure Workbook ADF Template ID"
}

output "workbook_databricks_id" {
  value       = length(var.name_to_id_map) == 0 ? "" : azurerm_application_insights_workbook.databricks[each.key].id
  description = "Azure Workbook Databricks Template ID"
}

output "dashboard_adf_id" {
  value       = length(var.adf_id) == 0 ? "" : azurerm_portal_dashboard.adf[each.value].id
  description = "Azure Shared Dashboard ADF ID"
}

output "dashboard_databricks_id" {
  value       = length(var.name_to_id_map) == 0 ? "" : azurerm_portal_dashboard.databricks[each.value].id
  description = "Azure Shared Dashboard Databricks ID"
}
*/
