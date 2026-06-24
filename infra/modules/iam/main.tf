resource "aws_iam_role" "gatus" {
  name = "gatus_exec_role"

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
}

resource "aws_iam_role_policy_attachment" "gatus_exec_role" {
  role       = aws_iam_role.gatus.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "gatus_task_role" {
  name = "gatus_task_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "gatus_ses_policy" {
  name = "gatus_ses_send_policy"
  role = aws_iam_role.gatus_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid      = "GatusSESSendPermissions"
      Effect   = "Allow"
      Action   = [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ]
      Resource = "*" 
    }]
  })
}


