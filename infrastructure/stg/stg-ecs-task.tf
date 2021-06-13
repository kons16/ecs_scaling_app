variable AWS_ECR_HOST_URL {}

resource "aws_ecs_task_definition" "main" {
  family = "main_task_definition"
  cpu = "256"
  memory = "512" 
  network_mode = "awsvpc"
  requires_compatibilities = ["EC2"]

  container_definitions = templatefile("./stg-ecs-task-definition.json", {
    AWS_ECR_HOST_URL = var.AWS_ECR_HOST_URL
  })
}
