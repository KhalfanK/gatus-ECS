output "gatus_exec_role_arn" {
  description = "the ARN of the ECS task execution role for gatus"
  value       = aws_iam_role.gatus.arn
}