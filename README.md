# admin-sites-terraform
## What is this repo?
This repo contains the required infrastructure for the Admin sites for EWF/XML.
This will be deployed to Staging and Live so the Terraform code is generic with var files per account in the profiles sub-directory (per group).

## The Groups of Terraform

### groups/adminsites-infrastructure
Contains the code required to build the infrastructure for the Admin sites, includes EC2, Autoscaling and Application Load balancers
