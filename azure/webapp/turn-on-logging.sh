#!/bin/bash

read -rp "Azure resource group name [Nova] : "  resource_group
read -rp 'Azure storage webapp name [nova-cloud-api] : '  webapp_name

resource_group=${resource_group:-Nova}
webapp_name=${webapp_name:-nova-cloud-api}

az webapp log config --name "$webapp_name" --resource-group "$resource_group" --docker-container-logging filesystem
az webapp log tail --name "$webapp_name" --resource-group "$resource_group"
