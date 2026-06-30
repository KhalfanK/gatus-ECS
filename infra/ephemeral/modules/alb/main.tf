resource "aws_alb_target_group" "main" {
  name        = "${var.name_prefix}-gatus-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "8080"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(local.module_tags, {
    Name = "${var.name_prefix}-gatus-tg"
  })
}

resource "aws_alb" "main" {
  name               = "${var.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(local.module_tags, {
    Name = "${var.name_prefix}-alb"
  })
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.arn
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}