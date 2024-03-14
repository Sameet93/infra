variable "name" {
  description = "Name of service"
}
variable "cluster" {
  description = "Cluster used in ecs"
}
variable "task_definition_arn" {
  description = "arn of the task definition used by the service"

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