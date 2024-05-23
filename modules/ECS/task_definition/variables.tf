variable "family" {
  description = "The family of your ECS Task Definition"
  type        = string
}

variable "cpu" {
  description = "The number of CPU units to reserve for the task"
  type        = string
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the task"
  type        = string
}

variable "skip_destroy" {
  description = "Whether to skip destroying the task definition"
  type        = bool
  default     = false
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "docker_image" {
  description = "The Docker image to use for the container"
  type        = string
}

variable "container_cpu" {
  description = "The number of CPU units to reserve for the container"
  type        = number
}

variable "container_memory" {
  description = "The amount of memory (in MiB) to reserve for the container"
  type        = number
}

variable "port_mappings" {
  description = "Port mappings for the container"
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
}
