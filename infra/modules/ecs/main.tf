resource "aws_ecs_cluster" "gatus_cluster" {
  name = "gatus_cluster"
}

resource "aws_cloudwatch_log_group" "gatus_logs" {
  name              = "/ecs/gatus"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "gatus_task_definition" {
  family                   = "gatus"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  
  execution_role_arn       = var.gatus_exec_role_arn

  container_definitions = jsonencode([
    {
      name      = "gatus"
      image     = "${var.ecr_repo_url}:latest"
      essential = true
      
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.gatus_logs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "gatus"
        }
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "gatus" {
  name            = "gatus"
  cluster         = aws_ecs_cluster.gatus_cluster.id
  task_definition = aws_ecs_task_definition.gatus_task_definition.arn
  desired_count   = 2
  launch_type     = "FARGATE"


  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "gatus"
    container_port   = 8080
  }

  network_configuration {
    subnets          = var.private_subnet_id
    security_groups  = [var.gatus_task_sg_id] 
    assign_public_ip = false                
  }

}