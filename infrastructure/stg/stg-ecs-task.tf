resource "aws_ecs_task_definition" "main" {
  family = "main_task_definition"
  
  network_mode = "awsvpc"
  container_definitions = "${file("./stg-ecs-task-definition.json")}"
}
