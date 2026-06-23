output "alb_sg_id" {
  description = "security group for alb"
  value = aws_security_group.alb_sg.id
}