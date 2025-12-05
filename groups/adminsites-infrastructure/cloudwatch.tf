resource "aws_cloudwatch_log_group" "ewfadmin" {
  for_each = local.ewfadmin_cw_logs

  name              = each.value["log_group_name"]
  retention_in_days = lookup(each.value, "log_group_retention", var.default_log_group_retention_in_days)
  kms_key_id        = lookup(each.value, "kms_key_id", local.logs_kms_key_id)

  tags = merge(
    local.default_tags,
    {
      ServiceTeam = "${upper(var.application)}-FE-Support"
    }
  )
}

resource "aws_cloudwatch_log_group" "xmladmin" {
  for_each = local.xmladmin_cw_logs

  name              = each.value["log_group_name"]
  retention_in_days = lookup(each.value, "log_group_retention", var.default_log_group_retention_in_days)
  kms_key_id        = lookup(each.value, "kms_key_id", local.logs_kms_key_id)

  tags = merge(
    local.default_tags,
    {
      ServiceTeam = "${upper(var.application)}-FE-Support"
    }
  )
}

resource "aws_cloudwatch_log_group" "xmloutadmin" {
  for_each = local.xmloutadmin_cw_logs

  name              = each.value["log_group_name"]
  retention_in_days = lookup(each.value, "log_group_retention", var.default_log_group_retention_in_days)
  kms_key_id        = lookup(each.value, "kms_key_id", local.logs_kms_key_id)

  tags = merge(
    local.default_tags,
    {
      ServiceTeam = "${upper(var.application)}-FE-Support"
    }
  )
}
