# ------------------------------------------------------------------------------
# AdminSites Security Group and rules
# ------------------------------------------------------------------------------
module "adminsites_asg_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "sgr-${var.application}-asg-001"
  description = "Security group for the ${var.application} autoscaling groups"
  vpc_id      = data.aws_vpc.vpc.id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.adminsites_internal_alb_security_group.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2

  egress_rules = ["all-all"]

  tags = merge(
    local.default_tags,
    map(
      "ServiceTeam", "${upper(var.application)}-FE-Support"
    )
  )
}