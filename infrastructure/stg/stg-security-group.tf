resource "aws_security_group" "sg" {
  name        = "my-sg"
  vpc_id      = aws_vpc.main.id

  # セキュリティグループ内のリソース から インターネット へのアクセスを許可する
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-app"
  }
}

resource "aws_security_group_rule" "sg-rule" {
  security_group_id = aws_security_group.sg.id

  # インターネット から セキュリティグループ内のリソース へののアクセスを許可する
  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}
