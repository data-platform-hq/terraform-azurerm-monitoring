resource "random_uuid" "adf" {}

resource "random_uuid" "databricks" {}

resource "azurerm_application_insights_workbook" "adf" {
  for_each = var.adf_map

  display_name        = "data-factory-${var.project}-${var.env}-${var.location}"
  name                = random_uuid.adf.result
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags

  data_json = jsonencode(templatefile("${path.module}/json/adf_workbook_template.tftpl", {
    adf_id = each.value
  }))
}

resource "azurerm_portal_dashboard" "adf" {
  for_each = var.adf_map

  name                = "data-factory-${var.project}-${var.env}-${var.location}"
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

resource "azurerm_portal_dashboard" "databricks" {
  for_each = var.log_analytics_workspace_map

  name                = "databricks-${var.project}-${var.env}-${var.location}"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = var.tags

  dashboard_properties = templatefile("${path.module}/json/databricks_dashboard_template.tftpl", {
    law_id = each.value
  })
}
