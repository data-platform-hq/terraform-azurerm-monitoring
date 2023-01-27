resource "random_uuid" "adf" {}

resource "random_uuid" "databricks" {}

locals {
  adf_name_to_id_map = { (var.adf_id) = "var.adf_id" }
}

resource "azurerm_application_insights_workbook" "adf" {
  for_each = length(local.adf_name_to_id_map) == 0 ? {} : local.adf_name_to_id_map

  display_name        = "data-factory-${var.project}-${var.env}-${var.location}"
  name                = random_uuid.adf.result
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags

  data_json = jsonencode(templatefile("../../modules/monitoring/json/adf_workbook_template.tftpl", {
    adf_id = each.value
  }))
}

resource "azurerm_portal_dashboard" "adf" {
  for_each = length(local.adf_name_to_id_map) == 0 ? {} : local.adf_name_to_id_map

  name                = "data-factory-${var.project}-${var.env}-${var.location}"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = var.tags

  dashboard_properties = templatefile("../../modules/monitoring/json/adf_dashboard_template.tftpl", {
    adf_id        = each.value,
    workbook_id   = azurerm_application_insights_workbook.adf[each.key].id,
    workbook_name = azurerm_application_insights_workbook.adf[each.key].name
  })
}

resource "azurerm_application_insights_workbook" "databricks" {
  for_each = length(var.name_to_id_map) == 0 ? {} : var.name_to_id_map

  display_name        = "databricks-${var.project}-${var.env}-${var.location}"
  name                = random_uuid.databricks.result
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags

  data_json = jsonencode(templatefile("../../modules/monitoring/json/databricks_workbook_template.tftpl", {
    law_id = each.value
  }))
}

resource "azurerm_portal_dashboard" "databricks" {
  for_each = length(var.name_to_id_map) == 0 ? {} : var.name_to_id_map

  name                = "databricks-${var.project}-${var.env}-${var.location}"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = var.tags

  dashboard_properties = templatefile("../../modules/monitoring/json/databricks_dashboard_template.tftpl", {
    law_id      = each.value,
    workbook_id = azurerm_application_insights_workbook.databricks[each.key].id
  })
}
