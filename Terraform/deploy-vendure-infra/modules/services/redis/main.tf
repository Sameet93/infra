resource "aws_elasticache_cluster" "example" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = var.instance_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = var.engine_version
  subnet_group_name    = var.subnet_group_name
  security_group_ids   = [var.security_group_id]
  availability_zone    = var.availability_zone
  port                 = 6379
}