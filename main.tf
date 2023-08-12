resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "global_rg_tfstate" {
  name     = "global-rg-tfstate"
  location = var.az_region # list location = az account list-locations -o table
  tags = {
    ManagedBy = "terraform"
  }
}

resource "azurerm_storage_account" "global_sa_tfstate" {
  name                            = "globalsatfstate${random_string.resource_code.result}" # name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long
  resource_group_name             = azurerm_resource_group.global_rg_tfstate.name
  location                        = azurerm_resource_group.global_rg_tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    ManagedBy = "terraform"
  }
}

resource "azurerm_storage_container" "global_sc_tfstate" {
  name                  = "global-sc-tfstate"
  storage_account_name  = azurerm_storage_account.global_sa_tfstate.name
  container_access_type = "private"
}