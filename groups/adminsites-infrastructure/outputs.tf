output "admin_sites_dns" {
  value = [for dns in aws_route53_record.internal_dns : dns.fqdn]
}
