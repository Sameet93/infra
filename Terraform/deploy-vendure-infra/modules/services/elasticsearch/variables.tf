variable "availability_zone_count" {
  description = "Number of Availability Zones for the domain to use."
  type        = number
}

variable "instance_type" {
  description = "Instance type to use for the Elasticsearch cluster."
  type        = string
}

variable "instance_count" {
  description = "Number of instances in the cluster."
  type        = number
}

variable "es_version" {
  description = "Version of Elasticsearch to deploy."
  type        = string
}

variable "subnet_ids" {
  description = "IDs of VPC Subnets where the Elasticsearch domain should be placed."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs to control access to the Elasticsearch domain."
  type        = list(string)
}