terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

data "cloudflare_zone" "main" {
  name = "kkhalfan.com"
}

resource "cloudflare_record" "acm_validation" {
  for_each = {
    for dvo in var.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      value = dvo.resource_record_value
      type  = dvo.resource_record_type
    }
  }

  zone_id = data.cloudflare_zone.main.id
  name    = each.value.name
  value   = each.value.value
  type    = each.value.type
  ttl     = 60
  proxied = false
}

resource "cloudflare_record" "gatus_traffic" {
  zone_id = data.cloudflare_zone.main.id
  name    = "@"             
  value   = var.alb_dns_name    
  type    = "CNAME"
  ttl     = 1                   
  proxied = false                
}
