terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "connection_pool_exhaustion_in_postgresql" {
  source    = "./modules/connection_pool_exhaustion_in_postgresql"

  providers = {
    shoreline = shoreline
  }
}