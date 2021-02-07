#!/bin/bash
read -rp 'Azure storage account name [novacloudstorage] : '  storage_account_name
read -rp 'Azure storage name [novacloudfileshare] : '  storage_name

storage_account_name=${storage_account_name:-novacloudstorage}
storage_name=${storage_name:-novacloudfileshare}

az storage share create \
  --name "$storage_name" \
  --account-name "$storage_account_name" \
  --quota 5
