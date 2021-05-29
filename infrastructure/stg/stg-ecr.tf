resource "aws_ecr_repository" "main" {
  name                 = "ecs_app_ecr"

  image_scanning_configuration {
    scan_on_push = true
  }
}