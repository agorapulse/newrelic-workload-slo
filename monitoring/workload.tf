module "workload" {
  source = "../modules/workload"

  newrelic_account_id = var.new_relic_account_id
  subdomain           = local.subdomain
  env                 = var.env
  tribe               = "Content"
}