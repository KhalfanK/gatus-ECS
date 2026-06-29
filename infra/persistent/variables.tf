variable "project" {
  description = "Name of Project"
  type = string
}

variable "environment" {
  description = "Name of Environment"
  type = string
}

variable "aws_region" {
  description = "Name of AWS Region"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR Block of VPC"
  type = string
}

variable "public_subnets" {
  description = "Map of Public Subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Map of Private Subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
}