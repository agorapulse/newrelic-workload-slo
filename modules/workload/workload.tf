
locals {
  entity_tag_to_search = length(var.override_tag_key) == 0 ? "SubDomain" : var.override_tag_key
}

resource "newrelic_workload" "feature_workload" {
  name       = "${title(var.tribe)}-${title(var.subdomain)}-${title(var.env)}"
  account_id = var.newrelic_account_id

  entity_search_query {
    query = "tags.label.${local.entity_tag_to_search} = '${title(var.subdomain)}' AND tags.label.Env = '${var.env}'"
  }

  scope_account_ids = [var.newrelic_account_id]
}