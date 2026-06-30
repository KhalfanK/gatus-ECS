locals {
  name_prefix = "${var.project}-${var.environment}"


  vpc_id             = data.aws_vpc.main.id
  public_subnet_ids  = data.aws_subnets.public.ids
  private_subnet_ids = data.aws_subnets.private.ids

  alb_sg_id        = data.aws_security_group.alb.id
  gatus_task_sg_id = data.aws_security_group.ecs.id

  ecr_repository_url  = data.aws_ecr_repository.gatus.repository_url
  acm_certificate_arn = data.aws_acm_certificate.cert.arn

  gatus_exec_role_arn = data.aws_iam_role.gatus_exec.arn
}
