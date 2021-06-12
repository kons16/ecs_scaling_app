resource "aws_lb" "lb" {
  name     = "ecs-app"
  internal = false

  subnets = [
    "your_subnetid",
    "your_subnetid",
  ]
  load_balancer_type = "network"
  enable_http2       = false
}

resource "aws_lb_target_group" "main" {
  name = "ecs-app"

  vpc_id = aws_vpc.main.id

  # ALBからECSタスクのコンテナへトラフィックを振り分ける設定
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    port = 80
    path = "/"
  }
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