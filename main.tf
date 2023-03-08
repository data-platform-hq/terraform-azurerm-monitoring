locals {
  adf_workbook_name         = var.custom_adf_workbook_name == null ? "data-factory-${var.project}-${var.env}-${var.location}" : var.custom_adf_workbook_name
  adf_dashboard_name        = var.custom_adf_dashboard_name == null ? "data-factory-${var.project}-${var.env}-${var.location}" : var.custom_adf_dashboard_name
  databricks_workbook_name  = var.custom_databricks_workbook_name == null ? "databricks-${var.project}-${var.env}-${var.location}" : var.custom_databricks_workbook_name
  databricks_dashboard_name = var.custom_databricks_dashboard_name == null ? "databricks-${var.project}-${var.env}-${var.location}" : var.custom_databricks_dashboard_name
}

resource "random_uuid" "adf" {
  for_each = var.adf_map
}

resource "random_uuid" "databricks" {
  for_each = var.log_analytics_workspace_map
}

resource "azurerm_application_insights_workbook" "adf" {
  for_each = var.adf_map

  display_name        = local.adf_workbook_name
  name                = random_uuid.adf[each.key].result
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags

  data_json = jsonencode(templatefile("${path.module}/json/adf_workbook_template.tftpl", {
    adf_id = each.value
  }))
}

resource "azurerm_portal_dashboard" "adf" {
  for_each = var.adf_map

  name                = local.adf_dashboard_name
  resource_group_name = var.resource_group
  location            = var.location
  tags                = var.tags

  dashboard_properties = templatefile("${path.module}/json/adf_dashboard_template.tftpl", {
    adf_id        = each.value,
    workbook_id   = azurerm_application_insights_workbook.adf[each.key].id,
    workbook_name = azurerm_application_insights_workbook.adf[each.key].name
  })

  depends_on = [azurerm_application_insights_workbook.adf]
}

resource "azurerm_application_insights_workbook" "databricks" {
  for_each = var.log_analytics_workspace_map

  display_name        = local.databricks_workbook_name
  name                = random_uuid.databricks[each.key].result
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags

  data_json = jsonencode(templatefile("${path.module}/json/databricks_workbook_template.tftpl", {
    law_id = each.value
  }))
}

resource "azurerm_portal_dashboard" "databricks" {
  for_each = var.log_analytics_workspace_map

  name                = local.databricks_dashboard_name
  resource_group_name = var.resource_group
  location            = var.location
  tags                = var.tags

  dashboard_properties = templatefile("${path.module}/json/databricks_dashboard_template.tftpl", {
    law_id      = each.value,
    workbook_id = azurerm_application_insights_workbook.databricks[each.key].id
  })

  depends_on = [azurerm_application_insights_workbook.databricks]
}
