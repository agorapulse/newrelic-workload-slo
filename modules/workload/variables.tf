variable "newrelic_account_id" {
  type = string
}
variable "subdomain" {
  type = string
}
variable "env" {
  type = string
}
variable "tribe" {
  default = "Platform"
  type    = string
}
variable "override_tag_key" {
  default = ""
  type    = string
}