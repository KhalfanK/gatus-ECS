output "alb_sg_id" {
  description = "security group for alb"
  value = aws_security_group.alb_sg.id
}

output "gatus_task_sg_id" {
  description = "security group for alb"
  value = aws_security_group.gatus_task_sg.id
}
