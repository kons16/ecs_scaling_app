resource "aws_ecs_service" "main" {
  name = "main_service"

  cluster = "${aws_ecs_cluster.main.name}"

  desired_count = "1"

  task_definition = "${aws_ecs_task_definition.main.arn}"

  network_configuration = {
    subnets         = ["${aws_subnet.private_1a.id}"]
    security_groups = ["${aws_security_group.ecs.id}"]
  }

  load_balancer = [
    {
      target_group_arn = "${aws_lb_target_group.main.arn}"
      container_name   = "nginx"
      container_port   = "80"
    },
  ]
}
