resource "aws_ecs_service" "postgres_service" {
  name            = var.name
  cluster         = var.cluster
  task_definition = var.task_definition_arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    security_groups  = var.security_groups
    subnets          = var.subnets
    assign_public_ip = var.public_ip
  }
}
