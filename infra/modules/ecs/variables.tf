variable "gatus_exec_role_arn" {
  type = string
}

variable "gatus_task_role_arn" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ecr_repo_url" {
  type = string
}

variable "alb_target_group_arn" {
  type = string
}

variable "gatus_task_sg_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "private_subnet_id" {
  type = list(string)
}