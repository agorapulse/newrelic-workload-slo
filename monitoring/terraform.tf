# Terraform dependencies versions
terraform {
  backend "local" {
    path = "./slo.tfstate"
  }
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.49.1"
    }
  }
}

provider "newrelic" {
  account_id = var.new_relic_account_id
  api_key    = var.new_relic_api_key
  region     = "US"
}