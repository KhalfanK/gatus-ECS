output "gatus_exec_role_arn" {
  description = "the ARN of the ECS task execution role for gatus to pull from ECR"
  value       = aws_iam_role.gatus.arn
}

output "gatus_task_role_arn" {
  description = "the ARN of the ECS task role for gatus to access SES"
  value       = aws_iam_role.gatus_task_role.arn
}