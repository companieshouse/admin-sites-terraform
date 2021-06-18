# ------------------------------------------------------------------------------
# Admin Sites Security Group and rules
# ------------------------------------------------------------------------------
module "adminsites_internal_alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "sgr-${var.application}-alb-001"
  description = "Security group for the ${var.application} web servers"
  vpc_id      = data.aws_vpc.vpc.id

  ingress_cidr_blocks = local.admin_cidrs
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
}

#--------------------------------------------
# Internal ALB Admin Sites
#--------------------------------------------
module "adminsites_internal_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name                       = "alb-${var.application}-001"
  vpc_id                     = data.aws_vpc.vpc.id
  internal                   = true
  load_balancer_type         = "application"
  enable_deletion_protection = true

  security_groups = [module.adminsites_internal_alb_security_group.this_security_group_id]
  subnets         = data.aws_subnet_ids.web.ids

  access_logs = {
    bucket  = local.elb_logs_s3_bucket_name
    prefix  = "elb-access-logs"
    enabled = true
  }

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = data.aws_acm_certificate.acm_cert.arn
      target_group_index = 0
    },
  ]

  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 1

      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        host_headers = ["ewfadmin-${var.domain_environment}-aws.${var.domain_name}"]
      }]
    },
    {
      https_listener_index = 0
      priority             = 2

      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]
      conditions = [{
        host_headers = ["xmladmin-${var.domain_environment}-aws.${var.domain_name}"]
      }]
    },
    {
      https_listener_index = 0
      priority             = 3

      actions = [
        {
          type               = "forward"
          target_group_index = 2
        }
      ]
      conditions = [{
        host_headers = ["xmloutadmin-${var.domain_environment}-aws.${var.domain_name}"]
      }]
    }
  ]
  target_groups = [
    {
      name                 = "tg-${var.application}-ewfadmin-01"
      backend_protocol     = "HTTP"
      backend_port         = var.service_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.health_check_path
        port                = var.service_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = {
        InstanceTargetGroupTag = "${var.application}-ewfadmin"
      }
    },
    {
      name                 = "tg-${var.application}-xmladmin-01"
      backend_protocol     = "HTTP"
      backend_port         = var.service_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.health_check_path
        port                = var.service_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = {
        InstanceTargetGroupTag = "${var.application}-xmladmin"
      }
    },
    {
      name                 = "tg-${var.application}-xmloutadmin-01"
      backend_protocol     = "HTTP"
      backend_port         = var.service_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.health_check_path
        port                = var.service_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = {
        InstanceTargetGroupTag = "${var.application}-xmloutadmin"
      }
    },
  ]

  tags = merge(
    local.default_tags,
    map(
      "ServiceTeam", "${upper(var.application)}-FE-Support"
    )
  )
}

#--------------------------------------------
# Internal ALB CloudWatch Merics
#--------------------------------------------
module "internal_alb_metrics" {
  source = "git@github.com:companieshouse/terraform-modules//aws/alb-metrics?ref=tags/1.0.26"

  load_balancer_id = module.adminsites_internal_alb.this_lb_id
  target_group_ids = module.adminsites_internal_alb.target_group_arns

  depends_on = [module.adminsites_internal_alb]
}