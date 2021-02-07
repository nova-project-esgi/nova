#!/bin/bash
read -rp "Azure resource group name [Nova] : "  resource_group
read -rp 'Azure storage account name [novacloudstorage] : '  storage_account_name
read -rp 'Azure storage location [westeurope] : ' storage_location

resource_group=${resource_group:-Nova}
storage_account_name=${storage_account_name:-novacloudstorage}
storage_location=${storage_location:-westeurope}

az storage account create \
    --resource-group "$resource_group" \
    --name "$storage_account_name" \
    --location "$storge_location" \
    --sku Standard_LRS
