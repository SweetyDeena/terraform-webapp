terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.34.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  common_tags = {
    ApplicationName  = "Phonebook"
    service = "Front-end"
  }
}

resource "azurerm_resource_group" "newTfWebApp" {
  name     = "MainWeb"
  location = "West Europe"
  tags     = local.common_tags
}

resource "azurerm_service_plan" "appwebS001" {
  name                = "appwebServ001"
  resource_group_name = azurerm_resource_group.newTfWebApp.name
  location            = azurerm_resource_group.newTfWebApp.location
  sku_name            = "P1v2"
  os_type             = "Windows"
  tags     = local.common_tags
}

resource "azurerm_windows_web_app" "winWebapp001" {
  name                = "windwebApp001"
  resource_group_name = azurerm_resource_group.newTfWebApp.name
  location            = azurerm_service_plan.appwebS001.location
  service_plan_id     = azurerm_service_plan.appwebS001.id
  tags     = local.common_tags

  site_config {}
}
