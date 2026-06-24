output "alb_target_group_arn" {
    description = "the ARN of alb target group"
    value = aws_alb_target_group.main.arn
}

output "domain_validation_options" {
    value = aws_acm_certificate.main.domain_validation_options
}

output "certificate_arn" {
    value = aws_acm_certificate.main.arn
}

output "alb_dns_name" {
  value = aws_alb.main.dns_name
}