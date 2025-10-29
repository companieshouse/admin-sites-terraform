# ASG Scheduled Shutdown for non-production
resource "aws_autoscaling_schedule" "xmladmin_schedule_stop" {
  count = var.environment == "live" ? 0 : 1

  scheduled_action_name  = "${var.aws_account}-${var.application}-xmladmin-scheduled-shutdown"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = "00 20 * * 1-5" #Mon-Fri at 8pm
  autoscaling_group_name = module.xmladmin_autoscaling_groups.this_autoscaling_group_name
}

# ASG Scheduled Startup for non-production
resource "aws_autoscaling_schedule" "xmladmin_schedule_start" {
  count = var.environment == "live" ? 0 : 1

  scheduled_action_name  = "${var.aws_account}-${var.application}-xmladmin-scheduled-startup"
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.desired_capacity
  recurrence             = "00 06 * * 1-5" #Mon-Fri at 6am
  autoscaling_group_name = module.xmladmin_autoscaling_groups.this_autoscaling_group_name
}

# ASG Module
module "xmladmin_autoscaling_groups" {
  source = "git@github.com:companieshouse/terraform-modules//aws/terraform-aws-autoscaling?ref=tags/1.0.357"

  name = "xmladmin-webserver"
  # Launch configuration
  lc_name       = "xmladmin-launchconfig"
  image_id      = data.aws_ami.adminsites.id
  instance_type = var.instance_size
  security_groups = [
    module.adminsites_asg_security_group.this_security_group_id,
    data.aws_security_group.nagios_shared.id
  ]
  root_block_device = [
    {
      volume_size = "40"
      volume_type = "gp3"
      encrypted   = true
      iops        = "3000"
      throughput  = "125"
    },
  ]
  # Auto scaling group
  asg_name                       = "xmladmin-asg"
  vpc_zone_identifier            = data.aws_subnets.web.ids
  health_check_type              = "ELB"
  min_size                       = var.min_size
  max_size                       = var.max_size
  desired_capacity               = var.desired_capacity
  health_check_grace_period      = 300
  wait_for_capacity_timeout      = 0
  force_delete                   = true
  enable_instance_refresh        = true
  refresh_min_healthy_percentage = 50
  refresh_triggers               = ["launch_configuration"]
  key_name                       = aws_key_pair.adminsites_keypair.key_name
  termination_policies           = ["OldestLaunchConfiguration"]
  target_group_arns              = [for group in module.adminsites_internal_alb.target_group_arns : group if can(regex("xmladmin", group))]
  iam_instance_profile           = module.xmladmin_iam_profile.aws_iam_instance_profile.name
  user_data_base64               = data.template_cloudinit_config.xmladmin.rendered

  tags_as_map = merge(
    local.default_tags,
    {
      ServiceTeam = "${upper(var.application)}-FE-Support"
    }
  )

  depends_on = [
    module.adminsites_internal_alb
  ]
}

#--------------------------------------------
# XML Admin CloudWatch Alarms
#--------------------------------------------
module "xmladmin_autoscaling_groups_alarms" {
  source = "git@github.com:companieshouse/terraform-modules//aws/asg-cloudwatch-alarms?ref=tags/1.0.357"

  autoscaling_group_name = module.xmladmin_autoscaling_groups.this_autoscaling_group_name
  prefix                 = "xmladmin-asg-alarms"

  in_service_evaluation_periods      = "3"
  in_service_statistic_period        = "120"
  expected_instances_in_service      = var.desired_capacity
  in_pending_evaluation_periods      = "3"
  in_pending_statistic_period        = "120"
  in_standby_evaluation_periods      = "3"
  in_standby_statistic_period        = "120"
  in_terminating_evaluation_periods  = "3"
  in_terminating_statistic_period    = "120"
  total_instances_evaluation_periods = "3"
  total_instances_statistic_period   = "120"
  total_instances_in_service         = var.desired_capacity

  actions_alarm = var.enable_sns_topic ? [module.cloudwatch_sns_notifications[0].sns_topic_arn] : []
  actions_ok    = var.enable_sns_topic ? [module.cloudwatch_sns_notifications[0].sns_topic_arn] : []


  depends_on = [
    module.cloudwatch_sns_notifications,
    module.xmladmin_autoscaling_groups
  ]
}