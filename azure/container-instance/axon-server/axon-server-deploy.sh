#!/bin/bash
read -rp "Azure resource group name [Nova] : "  resource_group
read -rp 'Azure storage account name [novacloudstorage] : '  storage_account_name
read -rp 'Azure storage name [novacloudfileshare] : '  storage_name

resource_group=${resource_group:-Nova}
storage_account_name=${storage_account_name:-novacloudstorage}
storage_name=${storage_name:-novacloudfileshare}

storage_key=$(bash "../storage/get-storage-key.sh" <<< "$resource_group" "$storage_account_name")

sed -i 's|STORAGE_KEY|'"$storage_key"'|g' deploy-aci.yaml
sed -i 's|STORAGE_ACCOUNT_NAME|'"$storage_account_name"'|g' deploy-aci.yaml
sed -i 's|STORAGE_NAME|'"$storage_name"'|g' deploy-aci.yaml
az container create --resource-group "$resource_group" --file deploy-aci.yaml
sed -i 's|'"$storage_key"'|STORAGE_KEY|g' deploy-aci.yaml
sed -i 's|'"$storage_account_name"'|STORAGE_ACCOUNT_NAME|g' deploy-aci.yaml
sed -i 's|'"$storage_name"'|STORAGE_NAME|g' deploy-aci.yaml
