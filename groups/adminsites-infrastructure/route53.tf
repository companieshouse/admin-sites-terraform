resource "aws_route53_record" "internal_dns" {
  for_each = toset(local.sites)

  zone_id = data.aws_route53_zone.private_zone.zone_id
  name    = each.value
  type    = "A"

  alias {
    name                   = module.adminsites_internal_alb.this_lb_dns_name
    zone_id                = module.adminsites_internal_alb.this_lb_zone_id
    evaluate_target_health = true
  }
}
