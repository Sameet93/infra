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
  task_role_arn      = var.task_role_arn
  # volume {
  #   name = "efs"
  #   efs_volume_configuration {
  #     file_system_id     = aws_efs_file_system.efs.id
  #     root_directory     = "/"
  #     transit_encryption = "ENABLED"
  #     authorization_config {
  #       access_point_id = aws_efs_access_point.access_point.id
  #       iam             = "ENABLED"
  #     }
  #   }
  # }
  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = var.ecr_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
      # mountPoints = [
      #   {
      #     sourceVolume  = "efs"
      #     containerPath = "/usr/share/elasticsearch/data"
      #     readOnly      = false
      #   },
      # ]
      environment = var.environmentVariables
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.td_service}"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    },
  ])

  tags = {
    createdBy    = var.created_by
    environment  = var.environment
    organization = var.organisation
  }
}

# resource "aws_efs_file_system" "efs" {
#   creation_token = "my-product"

#   tags = {
#     Name = "MyProduct"
#   }
# }

# resource "aws_efs_access_point" "access_point" {
#   file_system_id = aws_efs_file_system.efs.id

#   posix_user {
#     gid = 1000
#     uid = 1000
#   }

#   root_directory {
#     path = "/"

#     creation_info {
#       owner_gid   = 1000
#       owner_uid   = 1000
#       permissions = "777"
#     }
#   }
# }

# resource "aws_efs_mount_target" "efs_mount_target" {
#   file_system_id  = aws_efs_file_system.efs.id
#   subnet_id       = var.subnet_id # update this with your subnet id
#   security_groups = [aws_security_group.efs_sg.id]
# }

# resource "aws_security_group" "efs_sg" {
#   name   = "efs_sg"
#   vpc_id = var.vpc_id

#   ingress {
#     from_port   = 2049
#     to_port     = 2049
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # adjust this to match your network configuration
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
