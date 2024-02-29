data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "my_record" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = "test.${var.domain_name}"
  type    = var.record_type

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.zone_id
    evaluate_target_health = false
  }
}
