# ewf-infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0, < 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 0.3, < 4.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 0.3, < 4.0 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_adminsites_asg_security_group"></a> [adminsites\_asg\_security\_group](#module\_adminsites\_asg\_security\_group) | terraform-aws-modules/security-group/aws | ~> 3.0 |
| <a name="module_adminsites_internal_alb"></a> [adminsites\_internal\_alb](#module\_adminsites\_internal\_alb) | terraform-aws-modules/alb/aws | ~> 5.0 |
| <a name="module_adminsites_internal_alb_security_group"></a> [adminsites\_internal\_alb\_security\_group](#module\_adminsites\_internal\_alb\_security\_group) | terraform-aws-modules/security-group/aws | ~> 3.0 |
| <a name="module_cloudwatch_sns_notifications"></a> [cloudwatch\_sns\_notifications](#module\_cloudwatch\_sns\_notifications) | terraform-aws-modules/sns/aws | 3.3.0 |
| <a name="module_ewfadmin_autoscaling_groups"></a> [ewfadmin\_autoscaling\_groups](#module\_ewfadmin\_autoscaling\_groups) | git@github.com:companieshouse/terraform-modules//aws/terraform-aws-autoscaling?ref=tags/1.0.36 |  |
| <a name="module_ewfadmin_autoscaling_groups_alarms"></a> [ewfadmin\_autoscaling\_groups\_alarms](#module\_ewfadmin\_autoscaling\_groups\_alarms) | git@github.com:companieshouse/terraform-modules//aws/asg-cloudwatch-alarms?ref=tags/1.0.108 |  |
| <a name="module_ewfadmin_iam_profile"></a> [ewfadmin\_iam\_profile](#module\_ewfadmin\_iam\_profile) | git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59 |  |
| <a name="module_internal_alb_alarms"></a> [internal\_alb\_alarms](#module\_internal\_alb\_alarms) | git@github.com:companieshouse/terraform-modules//aws/alb-cloudwatch-alarms?ref=tags/1.0.104 |  |
| <a name="module_xmladmin_autoscaling_groups"></a> [xmladmin\_autoscaling\_groups](#module\_xmladmin\_autoscaling\_groups) | git@github.com:companieshouse/terraform-modules//aws/terraform-aws-autoscaling?ref=tags/1.0.36 |  |
| <a name="module_xmladmin_autoscaling_groups_alarms"></a> [xmladmin\_autoscaling\_groups\_alarms](#module\_xmladmin\_autoscaling\_groups\_alarms) | git@github.com:companieshouse/terraform-modules//aws/asg-cloudwatch-alarms?ref=tags/1.0.108 |  |
| <a name="module_xmladmin_iam_profile"></a> [xmladmin\_iam\_profile](#module\_xmladmin\_iam\_profile) | git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59 |  |
| <a name="module_xmloutadmin_autoscaling_groups"></a> [xmloutadmin\_autoscaling\_groups](#module\_xmloutadmin\_autoscaling\_groups) | git@github.com:companieshouse/terraform-modules//aws/terraform-aws-autoscaling?ref=tags/1.0.36 |  |
| <a name="module_xmloutadmin_autoscaling_groups_alarms"></a> [xmloutadmin\_autoscaling\_groups\_alarms](#module\_xmloutadmin\_autoscaling\_groups\_alarms) | git@github.com:companieshouse/terraform-modules//aws/asg-cloudwatch-alarms?ref=tags/1.0.108 |  |
| <a name="module_xmloutadmin_iam_profile"></a> [xmloutadmin\_iam\_profile](#module\_xmloutadmin\_iam\_profile) | git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59 |  |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_schedule.ewfadmin_schedule_start](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.ewfadmin_schedule_stop](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.xmladmin_schedule_start](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.xmladmin_schedule_stop](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.xmloutadmin_schedule_start](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.xmloutadmin_schedule_stop](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_cloudwatch_log_group.ewfadmin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.xmladmin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.xmloutadmin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_key_pair.adminsites_keypair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_record.internal_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_acm_certificate.acm_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_ami.adminsites](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_route53_zone.private_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_security_group.nagios_shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet_ids.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [template_cloudinit_config.ewfadmin](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |
| [template_cloudinit_config.xmladmin](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |
| [template_cloudinit_config.xmloutadmin](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |
| [template_file.ewfadmin](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.xmladmin](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.xmloutadmin](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [vault_generic_secret.account_ids](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.adminsites_ec2_data](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.ewfadmin_data](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.internal_cidrs](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.kms_keys](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.s3_releases](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.security_kms_keys](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.security_s3_buckets](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.xmladmin_data](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.xmloutadmin_data](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | Short version of the name of the AWS Account in which resources will be administered | `string` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | The name of the application | `string` | n/a | yes |
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The name of the AWS Account in which resources will be administered | `string` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS profile to use | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region in which resources will be administered | `string` | n/a | yes |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The desired capacity of ASGs, shared across all sites as they should be the same | `number` | n/a | yes |
| <a name="input_domain_environment"></a> [domain\_environment](#input\_domain\_environment) | shortform name for the environment | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment | `string` | n/a | yes |
| <a name="input_ewfadmin_app_release_version"></a> [ewfadmin\_app\_release\_version](#input\_ewfadmin\_app\_release\_version) | Version of the application to download for deployment to frontend server(s) | `string` | n/a | yes |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | The size of the ec2 instances to build | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The max size of the ASGs, shared across all sites as they should be the same | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The min size of the ASGs, shared across all sites as they should be the same | `number` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Short version of the name of the AWS region in which resources will be administered | `string` | n/a | yes |
| <a name="input_vault_password"></a> [vault\_password](#input\_vault\_password) | Password for connecting to Vault - usually supplied through TF\_VARS | `string` | n/a | yes |
| <a name="input_vault_username"></a> [vault\_username](#input\_vault\_username) | Username for connecting to Vault - usually supplied through TF\_VARS | `string` | n/a | yes |
| <a name="input_xmladmin_app_release_version"></a> [xmladmin\_app\_release\_version](#input\_xmladmin\_app\_release\_version) | Version of the application to download for deployment to frontend server(s) | `string` | n/a | yes |
| <a name="input_xmloutadmin_app_release_version"></a> [xmloutadmin\_app\_release\_version](#input\_xmloutadmin\_app\_release\_version) | Version of the application to download for deployment to frontend server(s) | `string` | n/a | yes |
| <a name="input_ami_name"></a> [ami\_name](#input\_ami\_name) | Name of the AMI to use in the Auto Scaling configuration for frontend server(s) | `string` | `"admin-sites-*"` | no |
| <a name="input_cw_logs"></a> [cw\_logs](#input\_cw\_logs) | Map of log file information; used to create log groups, IAM permissions and passed to the application to configure remote logging | `map(any)` | `{}` | no |
| <a name="input_default_log_group_retention_in_days"></a> [default\_log\_group\_retention\_in\_days](#input\_default\_log\_group\_retention\_in\_days) | Total days to retain logs in CloudWatch log group if not specified for specific logs | `number` | `14` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Top level domain dame | `string` | `"companieshouse.gov.uk"` | no |
| <a name="input_enable_sns_topic"></a> [enable\_sns\_topic](#input\_enable\_sns\_topic) | A boolean value to alter deployment of an SNS topic for CloudWatch actions | `bool` | `false` | no |
| <a name="input_ewfadmin_custom_logs"></a> [ewfadmin\_custom\_logs](#input\_ewfadmin\_custom\_logs) | Map of log file information for EWF Admin specifically; used to create log groups, IAM permissions and passed to the application to configure remote logging | `map(any)` | `{}` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Target group health check path | `string` | `"/"` | no |
| <a name="input_nfs_mount_destination_parent_dir"></a> [nfs\_mount\_destination\_parent\_dir](#input\_nfs\_mount\_destination\_parent\_dir) | The parent folder that all NFS shares should be mounted inside on the EC2 instance | `string` | `"/mnt"` | no |
| <a name="input_nfs_mounts"></a> [nfs\_mounts](#input\_nfs\_mounts) | A map of objects which contains mount details for each mount path required. | `map(any)` | <pre>{<br>  "NFSTest": {<br>    "local_mount_point": "folder",<br>    "mount_options": [<br>      "rw",<br>      "wsize=8192"<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_nfs_server"></a> [nfs\_server](#input\_nfs\_server) | The name or IP of the environment specific NFS server | `string` | `null` | no |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Target group backend port | `number` | `80` | no |
| <a name="input_xmladmin_custom_logs"></a> [xmladmin\_custom\_logs](#input\_xmladmin\_custom\_logs) | Map of log file information for XML Admin specifically; used to create log groups, IAM permissions and passed to the application to configure remote logging | `map(any)` | `{}` | no |
| <a name="input_xmloutadmin_custom_logs"></a> [xmloutadmin\_custom\_logs](#input\_xmloutadmin\_custom\_logs) | Map of log file information for XMLOUT Admin specifically; used to create log groups, IAM permissions and passed to the application to configure remote logging | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_sites_dns"></a> [admin\_sites\_dns](#output\_admin\_sites\_dns) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->