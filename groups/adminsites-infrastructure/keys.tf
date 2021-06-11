# ------------------------------------------------------------------------------
# EWF Key Pair
# ------------------------------------------------------------------------------

resource "aws_key_pair" "adminsites_keypair" {
  key_name   = var.application
  public_key = local.adminsites_ec2_data["public-key"]
}
