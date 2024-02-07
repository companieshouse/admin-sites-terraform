# ------------------------------------------------------------------------
# Locals
# ------------------------------------------------------------------------
locals {
  admin_cidrs         = values(data.vault_generic_secret.internal_cidrs.data)
  s3_releases         = data.vault_generic_secret.s3_releases.data
  adminsites_ec2_data = data.vault_generic_secret.adminsites_ec2_data.data

  kms_keys_data               = data.vault_generic_secret.kms_keys.data
  account_ssm_key_arn         = local.kms_keys_data["ssm"]
  sns_kms_key_id              = local.kms_keys_data["sns"]
  logs_kms_key_id             = local.kms_keys_data["logs"]
  ssm_kms_key_id              = data.vault_generic_secret.security_kms_keys.data["session-manager-kms-key-arn"]
  session_manager_bucket_name = data.vault_generic_secret.security_s3_buckets.data["session-manager-bucket-name"]
  elb_logs_s3_bucket_name     = data.vault_generic_secret.security_s3_buckets.data["elb-access-logs-bucket-name"]

  internal_fqdn = format("%s.%s.aws.internal", split("-", var.aws_account)[1], split("-", var.aws_account)[0])

  ###### Admin Site Details #######
  sites = [
    "ewfadmin",
    "xmladmin",
    "xmloutadmin"
  ]

  #################################

  ##### CLOUDWATCH LOG INPUTS #####

  #For each log map passed, add an extra kv for the log group name
  ewfadmin_cw_logs    = { for log, map in merge(var.cw_logs, var.ewfadmin_custom_logs) : log => merge(map, { "log_group_name" = "ewfadmin-${log}" }) }
  xmladmin_cw_logs    = { for log, map in merge(var.cw_logs, var.xmladmin_custom_logs) : log => merge(map, { "log_group_name" = "xmladmin-${log}" }) }
  xmloutadmin_cw_logs = { for log, map in merge(var.cw_logs, var.xmloutadmin_custom_logs) : log => merge(map, { "log_group_name" = "xmloutadmin-${log}" }) }

  ewfadmin_log_groups    = compact([for log, map in local.ewfadmin_cw_logs : lookup(map, "log_group_name", "")])
  xmladmin_log_groups    = compact([for log, map in local.xmladmin_cw_logs : lookup(map, "log_group_name", "")])
  xmloutadmin_log_groups = compact([for log, map in local.xmloutadmin_cw_logs : lookup(map, "log_group_name", "")])

  ################################

  ####### USER DATA INPUTS #######
  ewfadmin_ansible_inputs = {
    s3_bucket_releases         = local.s3_releases["release_bucket_name"]
    s3_bucket_configs          = local.s3_releases["config_bucket_name"]
    heritage_environment       = var.environment
    version                    = var.ewfadmin_app_release_version
    default_nfs_server_address = var.nfs_server
    mounts_parent_dir          = var.nfs_mount_destination_parent_dir
    mounts                     = var.nfs_mounts
    region                     = var.aws_region
    cw_log_files               = local.ewfadmin_cw_logs
    cw_agent_user              = "root"
  }

  xmladmin_ansible_inputs = {
    s3_bucket_releases         = local.s3_releases["release_bucket_name"]
    s3_bucket_configs          = local.s3_releases["config_bucket_name"]
    heritage_environment       = var.environment
    version                    = var.xmladmin_app_release_version
    default_nfs_server_address = var.nfs_server
    mounts_parent_dir          = var.nfs_mount_destination_parent_dir
    mounts                     = var.nfs_mounts
    region                     = var.aws_region
    cw_log_files               = local.xmladmin_cw_logs
    cw_agent_user              = "root"
  }

  xmloutadmin_ansible_inputs = {
    s3_bucket_releases         = local.s3_releases["release_bucket_name"]
    s3_bucket_configs          = local.s3_releases["config_bucket_name"]
    heritage_environment       = var.environment
    version                    = var.xmloutadmin_app_release_version
    default_nfs_server_address = var.nfs_server
    mounts_parent_dir          = var.nfs_mount_destination_parent_dir
    mounts                     = var.nfs_mounts
    region                     = var.aws_region
    cw_log_files               = local.xmloutadmin_cw_logs
    cw_agent_user              = "root"
  }

  parameter_store_path_prefix = "/${var.application}/${var.environment}"

  parameter_store_secrets = {
    ewfadmin_frontend_inputs            = data.vault_generic_secret.ewfadmin_data.data_json
    ewfadmin_frontend_ansible_inputs    = jsonencode(local.ewfadmin_ansible_inputs)
    xmladmin_frontend_inputs            = data.vault_generic_secret.xmladmin_data.data_json
    xmladmin_frontend_ansible_inputs    = jsonencode(local.xmladmin_ansible_inputs)
    xmloutadmin_frontend_inputs         = data.vault_generic_secret.xmloutadmin_data.data_json
    xmloutadmin_frontend_ansible_inputs = jsonencode(local.xmloutadmin_ansible_inputs)
  }

  ################################

  default_tags = {
    Terraform   = "true"
    Application = upper(var.application)
    Region      = var.aws_region
    Account     = var.aws_account
  }
}
