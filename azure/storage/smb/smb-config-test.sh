#!/bin/bash
read -rp 'Azure resource group name [Nova] : ' resource_group
read -rp 'Azure storage account name [novacloudstorage] : ' storage_account_name

resource_group=${resource_group:-Nova}
storage_account_name=${storage_account_name:-novacloudstorage}

# This command assumes you have logged in with az login
http_endpoint=$(az storage account show \
    --resource-group "$resource_group" \
    --name "$storage_account_name" \
    --query "primaryEndpoints.file" | tr -d '"')
smb_path=$(echo "$http_endpoint" | cut -c7-$(expr length "$http_endpoint"))
file_host=$(echo "$smb_path" | tr -d "/")

nc -zvw3 "$file_host" 445
