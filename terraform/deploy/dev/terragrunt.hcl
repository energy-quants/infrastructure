# This folder defines config for all sub-folders but doesn't define a terraform module itself
skip = true

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<-EOF
    terraform {
      required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "3.12.0"
        }
        null = {
          source  = "hashicorp/null"
          version = "3.1.1"
        }
        random = {
          source  = "hashicorp/random"
          version = "3.3.1"
        }
      }
    }
    provider "azurerm" {
      subscription_id = var.subscription_id
      features {}
    }
  EOF
}

# Inputs for the dev environment to inherit
inputs = {
  subscription_id = get_env("ARM_SUBSCRIPTION_ID")
}
