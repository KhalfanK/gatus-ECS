data "terraform_remote_state" "persistent" {
  backend = "s3"

  config = {
    bucket = "terraform-state-gatus"
    key    = "persistent/terraform.tfstate" 
    region = "eu-west-2"                   
  }
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["gatus-dev-vpc"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"] 
  }
}

data "aws_security_group" "alb" {
  vpc_id = data.aws_vpc.main.id
  name   = "gatus-dev-alb-sg"
}

data "aws_security_group" "ecs" {
  vpc_id = data.aws_vpc.main.id
  name   = "gatus-dev-gatus-task-sg"
}

data "aws_ecr_repository" "gatus" {
  name = "gatus"
}

data "aws_acm_certificate" "cert" {
  domain   = "tm.kkhalfan.com"
  statuses = ["ISSUED"]
}

data "aws_iam_role" "gatus_exec" {
  name = "gatus-dev-ecs-exec-role"
}