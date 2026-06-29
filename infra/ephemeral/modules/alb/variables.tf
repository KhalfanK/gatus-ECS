variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "name_prefix" {
  type = string
}