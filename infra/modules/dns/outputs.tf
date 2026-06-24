output "validation_record_fqdns" {
  value = [for record in cloudflare_record.acm_validation : record.hostname]
}