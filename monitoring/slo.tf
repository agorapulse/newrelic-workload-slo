locals {
  nrql_not_video = "AND mediaType != 'video'"
  services = {
    linkedin_not_video = {
      name        = "linkedin (not video)"
      objective   = 97.50
      service     = "linkedin"
      append_nrql = local.nrql_not_video
    }
    twitter_not_video = {
      name        = "twitter (not video)"
      objective   = 99.00
      service     = "twitter"
      append_nrql = local.nrql_not_video
    }
    facebook_not_video = {
      name        = "facebook (not video)"
      objective   = 99.00
      service     = "facebook"
      append_nrql = local.nrql_not_video
    }
    instagram_not_video = {
      name        = "instagram (not video)"
      objective   = 98.50
      service     = "instagram"
      append_nrql = local.nrql_not_video
    }
    tiktok = {
      name        = "tiktok"
      service     = "tiktok"
      objective   = 98.00
    }
    linkedin = {
      name        = "linkedin"
      objective   = 95.00
      service     = "linkedin"
    }
    twitter = {
      name        = "twitter"
      objective   = 99.00
      service     = "twitter"
    }
    facebook = {
      name        = "facebook"
      objective   = 98.00
      service     = "facebook"
    }
    instagram = {
      name        = "instagram"
      objective   = 98.00
      service     = "instagram"
    }
  }
}

resource "newrelic_service_level" "publishing_per_services" {
  for_each = local.services

  guid        = module.workload.guid
  name        = format("Publishing on %s", each.value.name)
  description = format("Proportion of Success Publisher on service %s.", each.value.name)

  events {
    account_id = var.new_relic_account_id
    valid_events {
      from  = "PublisherEvent"
      where = format("service = '%s' AND status != 'info' AND status != 'retry' AND environments='%s'", each.value.service, var.env)
    }
    bad_events {
      from  = "PublisherEvent"
      where = format("service = '%s' AND environments='%s' AND status = 'error' %s ", each.value.service, var.env, lookup(each.value, "append_nrql", ""))
    }
  }
  objective {
    target = each.value.objective
    time_window {
      rolling {
        count = 7
        unit  = "DAY"
      }
    }
  }
}