# NewRelic Workload SLOs using terraform

## Context

At agorapulse, we're divided into severals tribes, and tribes contains several squads.

Each squads are owner of their own infrastructure.

Their complete infrastructure is `as code`, using Terraform HCL language.

We're using a monorepo that contains every tribes and squad folders.
```
- tribe-name-1:
  - foo
  - bar
- tribe-name-2:
  - baz
  - foobar
```

If we take the case of conversation tribe, the conversation folder contains:
- `services` : containing all sources for serverless functions
- `apps` : containing all sources for apis
- `infra`: containing all terraform resources for all of their infrastructure:
  - `app`: deploying only api apps (and new relic alerts like checks 5XX error, instances count,... )
  - `lambda`: deploying AWS serverless functions (and new relic alerts like runtimes issues, overall status )
  - `data`: containing all AWS structured data (ElasticSearch, MySQL, Redis Cluster ... and ... alerting as well)
  - `monitoring`: containing NewRelic workload, and SLOs business based.

## About SLIs

On this monitoring layer, we would like to add some SLIs.

We are populating a new relic custom event called `PublisherEvent`.

This table contains the `status` (`info`, `retry`, `error`, `success`) and the type of publication (`mediaType`) of publication posted on social networks we use (tiktok, linkedin, facebook, youtube, instagram, ...).

We add several SLIs by network, 
- slis based on all publications,
- but also based on publication that doesn't contain videos (due to network issues, file size, ...)

see it into monitoring/slo.tf
```
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
```

## Run me !

```
cd monitoring
AWS_PROFILE=beta terraform init
AWS_PROFILE=beta terraform apply -var-file=environments/beta.tfvars  -var="new_relic_api_key=NRAK-FOOBAR" 
```