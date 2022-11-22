# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {}

terraform {
  backend "local" {
    path = "./tfstate/terraform.tfstate"
  }
}

module "networking" {
  depends_on = [random_id.this]
  source     = "./networking"
  suffix     = local.suffix
}

module "security" {
  source = "./security"
  suffix = local.suffix
}

module "storage" {
  source = "./storage"
  suffix = local.suffix
}

module "app" {
  depends_on                = [module.networking]
  source                    = "./app"
  suffix                    = local.suffix
  lambda_module_bucket_name = module.storage.bucket_name
  lambda_module_bucket_key  = module.storage.lambda_module_key
  vpc_id                    = module.networking.vpc_id
  public_subnets            = module.networking.public_subnet_ids
  private_subnets           = module.networking.private_subnet_ids
  private_subnet_cidr_block = module.networking.private_subnets_cidr_blocks
  database_subnets          = module.networking.database_subnet_ids
  iam_role_arn_lambda_proxy = module.security.iam_role_arn_lambda
  iam_role_profile_ec2_ssm  = module.security.iam_role_profile_ec2_ssm
}

module "database" {
  depends_on                = [module.networking]
  source                    = "./database"
  suffix                    = local.suffix
  vpc_id                    = module.networking.vpc_id
  private_subnet_cidr_block = module.networking.private_subnets_cidr_blocks
  private_subnet_ids        = module.networking.private_subnet_ids
  database_subnet_ids       = module.networking.database_subnet_ids
  database_username         = var.database_username
  database_password         = var.database_password
  iam_role_arn_rds_proxy    = module.security.iam_role_arn_rds_proxy
}
