output "vpc_id" {
  description = "id of the vpc"
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "cidr block of the vpc"
  value = aws_vpc.main.cidr_block
}

output "public_subnet_id" {
  description = "id of public subnets"
  value = [
    for subnet in aws_subnet.public : subnet.id
  ]
}

output "private_subnet_id" {
  description = "id of public subnets"
  value = [
    for subnet in aws_subnet.private : subnet.id
  ]
}

