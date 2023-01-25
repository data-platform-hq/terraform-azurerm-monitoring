locals {
  envs_list = length(var.cross_env) == 0 ? [var.adf_id] : tolist([for env in var.cross_env :
    "/subscriptions/${data.azurerm_client_config.this.subscription_id}/resourceGroups/${var.project}-${env}-${var.location}/providers/Microsoft.DataFactory/factories/adf-${var.project}-${env}-${var.location}"
  ])
}

data "azurerm_client_config" "this" {}

resource "random_uuid" "adf" {}

resource "random_uuid" "databricks" {}

resource "azurerm_application_insights_workbook" "adf" {
  count = var.adf_id == "" ? 0 : 1

  display_name        = "data-factory-${var.env}-${var.location}"
  name                = random_uuid.adf.result
  location            = var.location
  resource_group_name = var.resource_group

  data_json = jsonencode(templatefile("../../modules/monitoring/json/adf_workbook_template.tftpl", {
    adf_id = var.adf_id,
    envs   = jsonencode(local.envs_list)
  }))
}

resource "azurerm_portal_dashboard" "adf" {
  count = var.adf_id == "" ? 0 : 1

  name                = "data-factory-${var.env}-${var.location}"
  resource_group_name = var.resource_group
  location            = var.location

  dashboard_properties = templatefile("../../modules/monitoring/json/adf_dashboard_template.tftpl", {
    adf_id        = var.adf_id,
    workbook_id   = azurerm_application_insights_workbook.adf[0].id,
    workbook_name = azurerm_application_insights_workbook.adf[0].name
  })
  depends_on = [azurerm_application_insights_workbook.adf]
}

resource "azurerm_application_insights_workbook" "databricks" {
  display_name        = "databricks-${var.env}-${var.location}"
  name                = random_uuid.databricks.result
  location            = var.location
  resource_group_name = var.resource_group

  data_json = jsonencode(templatefile("../../modules/monitoring/json/databricks_workbook_template.tftpl", {
    law_id = var.law_id
  }))
}

resource "azurerm_portal_dashboard" "databricks" {
  name                = "databricks-${var.env}-${var.location}"
  resource_group_name = var.resource_group
  location            = var.location

  dashboard_properties = templatefile("../../modules/monitoring/json/databricks_dashboard_template.tftpl", {
    law_id      = var.law_id,
    workbook_id = azurerm_application_insights_workbook.databricks.id
  })
  depends_on = [azurerm_application_insights_workbook.databricks]
}
