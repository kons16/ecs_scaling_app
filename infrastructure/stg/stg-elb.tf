resource "aws_lb" "lb" {
  name     = "ecs-app"
  internal = false

  subnets = [
    aws_subnet.public_1a.id,
    aws_subnet.public_2a.id
  ]

  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
}

# ALBからECSタスクのコンテナへトラフィックを振り分ける設定
resource "aws_lb_target_group" "main" {
  name = "ecs-app"
  target_type = "ip"
  vpc_id = aws_vpc.main.id
  port        = 80
  protocol    = "HTTP"

  health_check {
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
  }

  depends_on = [aws_lb.lb]
}

# どのポートのリクエストを受け付けるか
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
