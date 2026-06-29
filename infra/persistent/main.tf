module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  name_prefix     = local.name_prefix
}

module "iam" {
  source = "./modules/iam"

  name_prefix     = local.name_prefix
}

module "security" {
  source = "./modules/security"

  vpc_id          = module.vpc.vpc_id
  name_prefix     = local.name_prefix
}

module "dns" {
  source      = "./modules/dns"
  
  domain_name = "kkhalfan.com"
  name_prefix = local.name_prefix
}