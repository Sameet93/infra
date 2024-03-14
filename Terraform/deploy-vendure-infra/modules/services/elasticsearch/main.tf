resource "aws_elasticsearch_domain" "es" {
  domain_name           = "vendure-es-domain"
  elasticsearch_version = var.es_version

  cluster_config {
    instance_type  = var.instance_type
    instance_count = var.instance_count
  }

  vpc_options {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = 50
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Domain = "Vendure ES Domain"
    environment = "staging"
  }
}