# ------------------------------------------------------------------------------
# Vault Variables
# ------------------------------------------------------------------------------
variable "vault_username" {
  type        = string
  description = "Username for connecting to Vault - usually supplied through TF_VARS"
}

variable "vault_password" {
  type        = string
  description = "Password for connecting to Vault - usually supplied through TF_VARS"
}

# ------------------------------------------------------------------------------
# AWS Variables
# ------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "The AWS region in which resources will be administered"
}

variable "aws_profile" {
  type        = string
  description = "The AWS profile to use"
}

variable "aws_account" {
  type        = string
  description = "The name of the AWS Account in which resources will be administered"
}

variable "domain_environment" {
  type        = string
  description = "shortform name for the environment"
}
# ------------------------------------------------------------------------------
# AWS Variables - Shorthand
# ------------------------------------------------------------------------------

variable "account" {
  type        = string
  description = "Short version of the name of the AWS Account in which resources will be administered"
}

variable "region" {
  type        = string
  description = "Short version of the name of the AWS region in which resources will be administered"
}

# ------------------------------------------------------------------------------
# Environment Variables
# ------------------------------------------------------------------------------

variable "application" {
  type        = string
  description = "The name of the application"
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "domain_name" {
  type        = string
  default     = "companieshouse.gov.uk"
  description = "Top level domain dame"
}

variable "enable_sns_topic" {
  type        = bool
  description = "A boolean value to alter deployment of an SNS topic for CloudWatch actions"
  default     = false
}
# ------------------------------------------------------------------------------
# NFS Variables
# ------------------------------------------------------------------------------

variable "nfs_server" {
  type        = string
  description = "The name or IP of the environment specific NFS server"
  default     = null
}

variable "nfs_mount_destination_parent_dir" {
  type        = string
  description = "The parent folder that all NFS shares should be mounted inside on the EC2 instance"
  default     = "/mnt"
}

variable "nfs_mounts" {
  type        = map(any)
  description = "A map of objects which contains mount details for each mount path required."
  default = {
    NFSTest = {                     # The name of the NFS Share from the NFS Server
      local_mount_point = "folder", # The name of the local folder to mount to if the share name is not wanted
      mount_options = [             # Traditional mount options as documented for any NFS Share mounts
        "rw",
        "wsize=8192"
      ]
    }
  }
}

# ------------------------------------------------------------------------------
# Admin Sites common variables
# ------------------------------------------------------------------------------
variable "service_port" {
  type        = number
  default     = 80
  description = "Target group backend port"
}

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "Target group health check path"
}

variable "default_log_group_retention_in_days" {
  type        = number
  default     = 14
  description = "Total days to retain logs in CloudWatch log group if not specified for specific logs"
}

variable "cw_logs" {
  type        = map(any)
  description = "Map of log file information; used to create log groups, IAM permissions and passed to the application to configure remote logging"
  default     = {}
}

variable "ami_name" {
  type        = string
  default     = "admin-sites-*"
  description = "Name of the AMI to use in the Auto Scaling configuration for frontend server(s)"
}

variable "desired_capacity" {
  type        = number
  description = "The desired capacity of ASGs, shared across all sites as they should be the same"
}

variable "min_size" {
  type        = number
  description = "The min size of the ASGs, shared across all sites as they should be the same"
}

variable "max_size" {
  type        = number
  description = "The max size of the ASGs, shared across all sites as they should be the same"
}

variable "instance_size" {
  type        = string
  description = "The size of the ec2 instances to build"
}

# ------------------------------------------------------------------------------
# EWF Admin Variables
# ------------------------------------------------------------------------------

variable "ewfadmin_app_release_version" {
  type        = string
  description = "Version of the application to download for deployment to frontend server(s)"
}

variable "ewfadmin_custom_logs" {
  type        = map(any)
  description = "Map of log file information for EWF Admin specifically; used to create log groups, IAM permissions and passed to the application to configure remote logging"
  default     = {}
}

# ------------------------------------------------------------------------------
# XML Admin Variables
# ------------------------------------------------------------------------------

variable "xmladmin_app_release_version" {
  type        = string
  description = "Version of the application to download for deployment to frontend server(s)"
}

variable "xmladmin_custom_logs" {
  type        = map(any)
  description = "Map of log file information for XML Admin specifically; used to create log groups, IAM permissions and passed to the application to configure remote logging"
  default     = {}
}

# ------------------------------------------------------------------------------
# XMLOUT Admin Variables
# ------------------------------------------------------------------------------

variable "xmloutadmin_app_release_version" {
  type        = string
  description = "Version of the application to download for deployment to frontend server(s)"
}

variable "xmloutadmin_custom_logs" {
  type        = map(any)
  description = "Map of log file information for XMLOUT Admin specifically; used to create log groups, IAM permissions and passed to the application to configure remote logging"
  default     = {}
}

