module "alb" {
  source              = "./modules/alb"

  vpc_id              = local.vpc_id
  public_subnet_ids   = local.public_subnet_ids
  alb_sg_id           = local.alb_sg_id
  acm_certificate_arn = local.acm_certificate_arn 

  name_prefix         = local.name_prefix
}

module "natgw" {
  source             = "./modules/natgw"
  
  name_prefix        = local.name_prefix
  vpc_id             = local.vpc_id
  public_subnet_ids  = local.public_subnet_ids
  private_subnet_ids = local.private_subnet_ids
}

module "ecs" {
  source               = "./modules/ecs"

  gatus_task_sg_id     = local.gatus_task_sg_id
  ecr_repo_url         = local.ecr_repository_url
  ecr_image_tag        = var.ecr_image_tag 
  alb_target_group_arn = module.alb.alb_target_group_arn 
  gatus_exec_role_arn  = local.gatus_exec_role_arn 
  private_subnet_ids   = local.private_subnet_ids
  aws_region           = var.aws_region
  name_prefix          = local.name_prefix

  depends_on = [module.natgw]
}

data "cloudflare_zone" "main" {
  name = "kkhalfan.com"
}

resource "cloudflare_record" "gatus_traffic" {
  zone_id = data.cloudflare_zone.main.id
  name    = "tm" 
  value   = module.alb.alb_dns_name
  type    = "CNAME"
  ttl     = 1
  proxied = false
}
