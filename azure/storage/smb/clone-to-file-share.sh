#!/bin/bash
read -rp 'Azure resource group name [Nova] : ' resource_group
read -rp 'Azure storage account name [novacloudstorage] : ' storage_account_name
read -rp 'Azure file share name [axonfileshare] : ' file_share_name
read -rp 'Src dir : ' src_dir

resource_group=${resource_group:-Nova}
storage_account_name=${storage_account_name:-novacloudstorage}
file_share_name=${file_share_name:-axonfileshare}
echo "${src_dir: -1}"
echo "$resource_group"

if ! [ -d "$src_dir" ]; then
  echo "Cannot clone $src_dir doesn't exist !!"
  exit
fi

if [[ "${src_dir: -1}" == "/" ]]; then
  src_dir=${src_dir::-1}
fi
echo "$src_dir"


#mount_path=$(bash "./mount-file-share.sh" <<< "$storage_account_name" "$file_share_name" "$resource_group")

#cp "$src_dir/*" "$mount_path"
#
#sudo umount "$mount_path"
