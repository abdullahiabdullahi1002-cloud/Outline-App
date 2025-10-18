output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

output "domain_validation_options" {
  description = "Domain validation options required for DNS validation"
  value       = aws_acm_certificate.cert.domain_validation_options
}
