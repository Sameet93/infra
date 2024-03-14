variable "availability_zone" {
  type        = string
  description = "The Availability Zone in which to place the cache"
}

variable "instance_type" {
  type        = string
  description = "The instance type for Redis cache"
}

variable "engine_version" {
  type        = string
  description = "The Redis engine version"
}

variable "subnet_group_name" {
  type        = string
  description = "The name of the subnet group to be used for the cache"
}

variable "security_group_id" {
  type        = string
  description = "The security group ID for the cache"
}