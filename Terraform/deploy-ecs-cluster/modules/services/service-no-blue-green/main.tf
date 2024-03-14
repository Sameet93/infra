//  AWS ECS Service to run the task definition
resource "aws_ecs_service" "main" {
  count                  = 1
  name                   = var.name
  cluster                = var.cluster
  task_definition        = var.task_definition_arn
  scheduling_strategy    = "REPLICA"
  desired_count          = var.service_count
  force_new_deployment   = true
  enable_execute_command = true
  network_configuration {
    security_groups  = var.security_groups
    subnets          = var.subnets
    assign_public_ip = var.public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.container_name
    container_port   = var.port
  }

  depends_on = [
    aws_lb_listener.lb_listener,
  ]

  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition,
    ]
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 100
    base              = 1
  }

  deployment_controller {
    type = "ECS"
  }
}
resource "aws_lb" "loadbalancer_ecs" {
  name               = "${var.name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_security_groups
  subnets            = ["subnet-fa6e40a0", "subnet-80ed00f9", "subnet-fb4fb2b0"]

  enable_deletion_protection = false
}
// AWS ELB Target Blue groups/Listener for Blue/Green Deployments
resource "aws_lb_target_group" "tg" {
  name        = "${var.name}-tg-2"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    matcher = "200-499"
    healthy_threshold = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.loadbalancer_ecs.arn
  protocol          = "HTTP"
  port              = 80

  depends_on = [aws_lb_target_group.tg]

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}

resource "aws_appautoscaling_target" "main" {
  count              = 1
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster}/${aws_ecs_service.main[count.index].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = var.auto_scale_role
  min_capacity       = var.min_scale
  max_capacity       = var.max_scale

  lifecycle {
    ignore_changes = [
      role_arn,
    ]
  }
}

// AWS Autoscaling policy to scale using cpu allocation
resource "aws_appautoscaling_policy" "cpu" {
  count              = 1
  name               = "ecs_scale_cpu"
  resource_id        = aws_appautoscaling_target.main[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.main[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.main[count.index].service_namespace
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 75
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }

  depends_on = [aws_appautoscaling_target.main]
}

// AWS Autoscaling policy to scale using memory allocation
resource "aws_appautoscaling_policy" "memory" {
  count              = 1
  name               = "ecs_scale_memory"
  resource_id        = aws_appautoscaling_target.main[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.main[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.main[count.index].service_namespace
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 75
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }

  depends_on = [
    aws_appautoscaling_target.main
  ]
}
