#!/bin/bash

# Function to clone repositories for a given organization
clone_repos_for_org() {
    local org="$1"
    shift
    local repos=("$@")

    # Ensure base directory exists
    mkdir -p ~/repo/github/"$org"
    cd ~/repo/github/"$org" || exit 1

    local base_url="https://github.com/$org"

    for repo in "${repos[@]}"; do
        if [ ! -d "$repo" ]; then
            git clone "$base_url/$repo.git"
        else
            echo "$repo already exists locally in $org."
        fi
    done
}

# Setting global git config
git config --global user.name "$1"
git config --global user.email "$2"

# Cloning repos from blinqas
clone_repos_for_org "blinqas" \
    "caf-terraform-landingzones" \
    "terraform-azurerm-caf" \
    "rover" \
    "terraform-azurerm-caf-enterprise-scale" \
    "terraform-provider-azurecaf" \
    "Enterprise-Scale" \
    "azure-policy" \
    "azlz-workflows" \
    "azlz-template" \
    "azlz-scripts"

# Cloning repos from aztfmod
clone_repos_for_org "aztfmod" \
    "terraform-azurerm-caf" \
    "documentation" \
    "rover" \
    "terraform-provider-azurecaf"

# Cloning repos from Azure
clone_repos_for_org "azure" \
    "terraform-azurerm-caf-enterprise-scale" \
    "azure-cli" \
    "azure-rest-api-specs"
