resource "aws_acm_certificate_validation" "gatus" {
  certificate_arn         = module.alb_acm.certificate_arn
  validation_record_fqdns = module.dns.validation_record_fqdns
}

module "networking" {
  source = "./modules/networking"

  vpc_cidr             = var.vpc_cidr
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  aws_region           = var.aws_region
}

module "alb_acm" {
  source = "./modules/alb_acm"

  alb_sg_id            = module.security.alb_sg_id
  public_subnet_id     = module.networking.public_subnet_id
  vpc_id               = module.networking.vpc_id
}

module "security" {
  source = "./modules/security"

  vpc_id               = module.networking.vpc_id
}

module "ecs" {
  source = "./modules/ecs"

  gatus_exec_role_arn  = module.iam.gatus_exec_role_arn
  ecr_repo_url         = module.ecr.repo_url
  alb_target_group_arn = module.alb_acm.alb_target_group_arn
  private_subnet_id    = module.networking.private_subnet_id
  alb_sg_id            = module.security.alb_sg_id
  gatus_task_sg_id     = module.security.gatus_task_sg_id
  aws_region           = var.aws_region

  depends_on = [
    aws_acm_certificate_validation.gatus
  ]
}

module "dns" {
  source = "./modules/dns"

  domain_name = "kkhalfan.com"
  domain_validation_options = module.alb_acm.domain_validation_options
  alb_dns_name = module.alb_acm.alb_dns_name
}

module "iam" {
  source = "./modules/iam"
}

module "ecr" {
  source = "./modules/ecr"
}
