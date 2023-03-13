locals {
  domain    = "platform"
  subdomain = "conversation"

  infrastructure_tags = merge(
    {
      SubDomain = title(local.subdomain)
      Domain    = title(local.domain)
      Env       = var.env
    }
  )
}