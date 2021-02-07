#!/bin/bash

read -rp 'Azure resource group name [Nova] : ' resource_group
read -rp 'Azure storage account name [novacloudstorage] : ' storage_account_name
read -rp 'Azure file share name [axonfileshare] : ' file_share_name

resource_group=${resource_group:-Nova}
storage_account_name=${storage_account_name:-novacloudstorage}
file_share_name=${file_share_name:-axonfileshare}


mnt_path="./$storage_account_name/$file_share_name"

sudo mkdir -p "$mnt_path"
