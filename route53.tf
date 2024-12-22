resource "aws_route53_zone" "host_zone" {
  provider = aws.virginia
  name = var.full_domain_name
}

resource "aws_route53_record" "cert" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  zone_id         = aws_route53_zone.host_zone.zone_id
  ttl             = 60
  depends_on = [aws_acm_certificate.cert, aws_route53_zone.host_zone]
}


resource "aws_route53_record" "site" {
  zone_id = aws_route53_zone.host_zone.zone_id
  name    = var.full_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}