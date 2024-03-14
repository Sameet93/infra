resource "aws_ecs_task_definition" "service" {
  family                   = var.td_service
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  network_mode       = "awsvpc"
  cpu                = var.container_cpu
  memory             = var.container_memory
  execution_role_arn = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = var.ecr_image
      links = [
        var.container_name_2
      ]
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
      environment = var.environmentVariables
    },
    {
      name      = var.container_name_2
      image     = var.ecr_image_2
      essential = true
      portMappings = [
        {
          containerPort = var.container_port_2
          hostPort      = var.host_port_2
        }
      ]
      environment = var.environmentVariables_2
    },
  ])
  tags = {
    createdBy    = var.created_by
    environment  = var.environment
    organization = var.organisation
  }
}
