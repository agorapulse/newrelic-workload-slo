variable "env" {
  description = "environment"
}

variable "new_relic_account_id" {
  description = "new relic account id contained on environments/XXXX.tfvars"
}

variable "new_relic_api_key" {
  type = string
}