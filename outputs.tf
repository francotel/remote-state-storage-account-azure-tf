output "resource_group_name" {
  value = azurerm_resource_group.global_rg_tfstate.name
}

output "storage_account" {
  value = azurerm_storage_account.global_sa_tfstate.name
}

output "storage_container" {
  value = azurerm_storage_container.global_sc_tfstate.name
}