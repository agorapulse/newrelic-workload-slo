# workload

## Context

On all our infrastructure modules using AWS provider, we attach some alerts based on :

- overall status,

- errors from serverless functions,

- (...)

All our providers resources are tagged with the same tags, subdomain AKA the feature.

|                |                                                                                                                                 |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Latest version | ![](https://img.shields.io/badge/workload-1.0.0-green)                                                       |
| Latest release | [workload-1.0.0](https://github.com/agorapulse/infra-modules/releases/tag/workload-1.0.0)      |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.4 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | >= 2.48.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | >= 2.48.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [newrelic_workload.feature_workload](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/workload) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_newrelic_account_id"></a> [newrelic\_account\_id](#input\_newrelic\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_override_tag_key"></a> [override\_tag\_key](#input\_override\_tag\_key) | n/a | `string` | `""` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | n/a | `string` | n/a | yes |
| <a name="input_tribe"></a> [tribe](#input\_tribe) | n/a | `string` | `"Platform"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_guid"></a> [guid](#output\_guid) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
