terraform {
  required_version = ">= 1.1.4"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">= 2.48.0"
    }
  }
}