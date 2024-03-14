variable "name" {
  description = "Name of service"
}
variable "cluster" {
  description = "Cluster used in ecs"
}
variable "task_definition_arn" {
  description = "arn of the task definition used by the service"

}
variable "service_count" {
  description = "Number of desired task"
  default     = 1
}
variable "security_groups" {
  description = "Security groups allowed"
  default     = []
}
variable "subnets" {
  description = "Private subnets from VPC"
  default     = ["subnet-fa6e40a0", "subnet-80ed00f9", "subnet-fb4fb2b0"]
}
variable "public_ip" {
  default     = false
  description = "Flag to set auto assign public ip"
}
variable "container_name" {
  description = "container name for the service"
}
variable "port" {
  description = "Port number exposed by container"
}
variable "lb_security_groups" {
  default = ["sg-04d1b5bc5e8076094"]
}
variable "vpc_id" {
  description = "VPC ID for create target group resources"
  default     = "vpc-f363d38a"
}
variable "auto_scale_role" {
  description = "IAM Role for autocaling services"
}
variable "min_scale" {
  description = "Minimun number of task scaling"
  default     = 1
}
variable "max_scale" {
  description = "Maximun number of task scaling"
  default     = 3
}
