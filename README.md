# Azure Monitoring Terraform module
Terraform module for creation Azure Workbooks and Dashboards for Databricks and Data Factory

## Usage
This module provides an ability to deploy Azure Dashboard and Workbook. Here is an example how to provision Azure workbook and shared dashboard for Azure databricks and Azure Data Factory

```hcl
locals {
  tags = {
    environment = "development"
  }
}

data "azurerm_data_factory" "example" {
  name                = "existing_adf"
  resource_group_name = "example_rg"
}

data "azurerm_log_analytics_workspace" "example" {
  name                = "existing_law"
  resource_group_name = "example_rg"
}

module "monitoring" {
  source  = "data-platform-hq/monitoring/azurerm"

  project                    = "datahq"
  env                        = "dev"
  location                   = "eastus"
  tags                       = local.tags
  resource_group             = "example_rg"
  azure_data_factory_id      = data.azurerm_data_factory.example.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.example.id
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version   |
| ------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.40.0 |
| <a name="requirement_random"></a> [random](#requirement\_random)          | >= 3.4.3  |

## Providers

| Name                                                          | Version |
| ------------------------------------------------------------- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.40.0  |
| <a name="provider_random"></a> [random](#provider\_random)    | 3.4.3   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                    | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------| -------- |
| [random_uuid.adf](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid)                                                  | resource |
| [random_uuid.databricks](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid)                                           | resource |
| [azurerm_application_insights_workbook.adf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_workbook_template) | resource |
| [azurerm_portal_dashboard.adf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/portal_dashboard)                        | resource |
| [azurerm_application_insights_workbook.databricks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_workbook_template) | resource |
| [azurerm_portal_dashboard.databricks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/portal_dashboard)                 | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group in which resources is created | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | {} | no |
| <a name="input_adf_map"></a> [adf\_map](#input\_adf\_map) | Azure Data Factory name to id map | `map(string)` | {} | no |
| <a name="input_log_analytics_workspace_map"></a> [log\_analytics\_workspace\_map](#input\_log\_analytics\_workspace\_map) | Azure Log Analytics name to id map | `map(string)` | {} | no |

## Outputs

| Name                                                                                                                | Description                                   |
|---------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| <a name="output_workbook_adf_id"></a> [workbook\_adf\_id](#output\_workbook\_adf\_id)                               | Azure Workbook ADF Template ID                |
| <a name="output_workbook_databricks_id"></a> [workbook\_databricks\_id](#output\_workbook\_databricks\_id)          | Azure Workbook Databricks Template ID         |
| <a name="output_dashboard_adf_id"></a> [dashboard\_adf\_id](#output\_dashboard\_adf\_id)                            | Azure Shared Dashboard ADF ID                 |
| <a name="output_dashboard_databricks_id"></a> [dashboard\_databricks\_id](#output\_dashboard\_databricks\_id)       | Azure Shared Dashboard Databricks ID          |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-monitoring/blob/main/LICENSE)
