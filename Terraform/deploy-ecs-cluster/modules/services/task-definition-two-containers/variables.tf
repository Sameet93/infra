variable "td_service" {
  type = string
}
variable "execution_role_arn" {
  type = string
}
variable "container_name" {
  type = string
}
variable "container_name_2" {
  type = string
}
variable "ecr_image" {
  type = string
}
variable "ecr_image_2" {
  type = string
}
variable "container_cpu" {
  type = number
}
variable "container_memory" {
  type = number
}
variable "container_port" {
  type = number
}
variable "container_port_2" {
  type = number
}
variable "host_port" {
  type    = number
  default = 3000
}
variable "host_port_2" {
  type    = number
  default = 3000
}
variable "environmentVariables" {
  type    = list(map(any))
  default = []
}
variable "environmentVariables_2" {
  type    = list(map(any))
  default = []
}
variable "created_by" {
  type = string
}
variable "environment" {
  type = string
}
variable "organisation" {
  type = string
}
