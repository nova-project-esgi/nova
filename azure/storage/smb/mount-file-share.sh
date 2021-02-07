#!/bin/bash
read -rp 'Azure resource group name [Nova] : ' resource_group
read -rp 'Azure storage account name [novacloudstorage] : ' storage_account_name
read -rp 'Azure file share name [axonfileshare] : ' file_share_name


resource_group=${resource_group:-Nova}
storage_account_name=${storage_account_name:-novacloudstorage}
file_share_name=${file_share_name:-axonfileshare}
mount_path="./$storage_account_name/$file_share_name"

if ! [ -d  "$mount_path" ]; then
  echo "Creating dir $mount_path ..."
  sudo mkdir -p "$mount_path"
fi

httpEndpoint=$(az storage account show \
    --resource-group "$resource_group" \
    --name "$storage_account_name" \
    --query "primaryEndpoints.file" | tr -d '"')
smb_path=$(echo "$httpEndpoint" | cut -c7-$(expr length "$httpEndpoint"))$file_share_name

storage_key=$(az storage account keys list \
    --resource-group "$resource_group" \
    --account-name "$storage_account_name" \
    --query "[0].value" | tr -d '"')

sudo mount -t cifs "$smb_path" "$mount_path" -o vers=3.0,username="$storage_account_name",password="$storage_key",serverino

echo mount_path
