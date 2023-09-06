# Placeholder example using an S3 module
# Your Terraform code goes here, after removing this code...

provider "aws" {
  alias  = "main"
  region = "eu-central-1"
}
provider "aws" {
  alias  = "replication"
  region = "us-east-1"
}

module "s3-module" {
  source = "git@github.com:biontechse/terraform-aws-storage-s3.git?ref=v1.0.0"
  providers = {
    aws.main        = aws.main
    aws.replication = aws.replication
  }
  bucket_prefix           = var.bucket_prefix
  cis_compliant           = false
  gxp_compliant           = false
  hipaa_compliant         = false
  application_environment = "DEV"
}