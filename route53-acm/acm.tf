# Certificate Request
resource "aws_acm_certificate" "hello_certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  tags = {
    Name : var.domain_name
  }

  lifecycle {
    create_before_destroy = true
  }
}
#Add record
resource "aws_route53_record" "hello_cert_dns" {
  allow_overwrite = true
  name =  tolist(aws_acm_certificate.hello_certificate.domain_validation_options)[0].resource_record_name
  records = [tolist(aws_acm_certificate.hello_certificate.domain_validation_options)[0].resource_record_value]
  type = tolist(aws_acm_certificate.hello_certificate.domain_validation_options)[0].resource_record_type
  zone_id = data.aws_route53_zone.hosted_zone.id
  ttl = 60
}
#validate
resource "aws_acm_certificate_validation" "hello_cert_validate" {
  certificate_arn = aws_acm_certificate.hello_certificate.arn
  validation_record_fqdns = [aws_route53_record.hello_cert_dns.fqdn]
}