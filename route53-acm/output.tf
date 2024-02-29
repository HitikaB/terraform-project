output "certificate_arn" {
  description = "Certificate arn"
  value = aws_acm_certificate.hello_certificate.arn
}