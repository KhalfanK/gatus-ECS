resource "aws_iam_role" "gatus" {
  name = "${var.name_prefix}-ecs-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.module_tags, {
    Name = "${var.name_prefix}-ecs-exec-role"
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.gatus.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}