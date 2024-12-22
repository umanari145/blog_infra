resource "aws_acm_certificate" "cert" {
  provider          = aws.virginia
  domain_name       = var.full_domain_name
  subject_alternative_names = ["*.${var.full_domain_name}"]
  validation_method = "DNS"
}

# ACMのDNS検証用レコードのチェック
resource "aws_acm_certificate_validation" "cert" {
  provider                = aws.virginia
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = flatten([values(aws_route53_record.cert)[*].fqdn])
  depends_on = [aws_acm_certificate.cert, aws_route53_record.cert]
}