#!/bin/bash
read -rp 'Azure resource group name [Nova] : ' resource_group
read -rp 'Azure storage account name [novacloudstorage] : ' storage_account_name

resource_group=${resource_group:-Nova}
storage_account_name=${storage_account_name:-novacloudstorage}

azure_key=$(az storage account keys list --resource-group "$resource_group" --account-name "$storage_account_name" --query "[0].value" --output tsv)
echo "$azure_key"
