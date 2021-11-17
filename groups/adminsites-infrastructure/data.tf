data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  tags = {
    Name = "vpc-${var.aws_account}"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = ["sub-public-*"]
  }
}

data "aws_subnet_ids" "web" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = ["sub-web-*"]
  }
}

data "aws_security_group" "nagios_shared" {
  filter {
    name   = "group-name"
    values = ["sgr-nagios-inbound-shared-*"]
  }
}

data "aws_route53_zone" "private_zone" {
  name         = local.internal_fqdn
  private_zone = true
}

data "vault_generic_secret" "account_ids" {
  path = "aws-accounts/account-ids"
}

data "vault_generic_secret" "s3_releases" {
  path = "aws-accounts/shared-services/s3"
}

data "vault_generic_secret" "internal_cidrs" {
  path = "aws-accounts/network/internal_cidr_ranges"
}

data "vault_generic_secret" "kms_keys" {
  path = "aws-accounts/${var.aws_account}/kms"
}

data "vault_generic_secret" "security_kms_keys" {
  path = "aws-accounts/security/kms"
}

data "vault_generic_secret" "security_s3_buckets" {
  path = "aws-accounts/security/s3"
}

data "vault_generic_secret" "adminsites_ec2_data" {
  path = "applications/${var.aws_account}-${var.aws_region}/${replace(var.application, "-", "")}/ec2"
}

data "vault_generic_secret" "ewfadmin_data" {
  path = "applications/${var.aws_account}-${var.aws_region}/${replace(var.application, "-", "")}/ewfadmin"
}

data "vault_generic_secret" "xmladmin_data" {
  path = "applications/${var.aws_account}-${var.aws_region}/${replace(var.application, "-", "")}/xmladmin"
}

data "vault_generic_secret" "xmloutadmin_data" {
  path = "applications/${var.aws_account}-${var.aws_region}/${replace(var.application, "-", "")}/xmloutadmin"
}



data "aws_acm_certificate" "acm_cert" {
  domain = "*.${var.domain_name}"
}

data "aws_ami" "adminsites" {
  owners      = [data.vault_generic_secret.account_ids.data["development"]]
  most_recent = var.ami_name == "admin-sites-*" ? true : false

  filter {
    name = "name"
    values = [
      var.ami_name,
    ]
  }

  filter {
    name = "state"
    values = [
      "available",
    ]
  }
}

# ------------------------------------------------------------------------------
# EWF Admin data
# ------------------------------------------------------------------------------
data "template_file" "ewfadmin" {
  template = file("${path.module}/templates/ewfadmin_user_data.tpl")

  vars = {
    REGION               = var.aws_region
    HERITAGE_ENVIRONMENT = title(var.environment)
    FRONTEND_INPUTS      = data.vault_generic_secret.ewfadmin_data.data_json
    ANSIBLE_INPUTS       = jsonencode(local.ewfadmin_ansible_inputs)
  }
}

data "template_cloudinit_config" "ewfadmin" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.ewfadmin.rendered
  }
}

# ------------------------------------------------------------------------------
# XML Admin data
# ------------------------------------------------------------------------------
data "template_file" "xmladmin" {
  template = file("${path.module}/templates/xmladmin_user_data.tpl")

  vars = {
    REGION               = var.aws_region
    HERITAGE_ENVIRONMENT = title(var.environment)
    FRONTEND_INPUTS      = data.vault_generic_secret.xmladmin_data.data_json
    ANSIBLE_INPUTS       = jsonencode(local.xmladmin_ansible_inputs)
  }
}

data "template_cloudinit_config" "xmladmin" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.xmladmin.rendered
  }
}

# ------------------------------------------------------------------------------
# XMLOUT Admin data
# ------------------------------------------------------------------------------
data "template_file" "xmloutadmin" {
  template = file("${path.module}/templates/xmloutadmin_user_data.tpl")

  vars = {
    REGION               = var.aws_region
    HERITAGE_ENVIRONMENT = title(var.environment)
    FRONTEND_INPUTS      = data.vault_generic_secret.xmloutadmin_data.data_json
    ANSIBLE_INPUTS       = jsonencode(local.xmloutadmin_ansible_inputs)
  }
}

data "template_cloudinit_config" "xmloutadmin" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.xmloutadmin.rendered
  }
}
