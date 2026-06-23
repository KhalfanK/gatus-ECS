module "networking" {
  source = "./modules/networking"

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  aws_region      = var.aws_region
}

module "alb_acm" {
  source = "./modules/alb_acm"

  alb_sg_id      = module.security.alb_sg_id
  public_subnet_id = module.networking.public_subnet_id
  vpc_id         = module.networking.vpc_id
}

module "security" {
  source = "./modules/security"

  vpc_cidr       = var.vpc_cidr
  vpc_id         = module.networking.vpc_id
}

