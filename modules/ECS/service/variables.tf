variable "name" {
  description = "The name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "The ARN of the ECS task definition"
  type        = string
}

variable "desired_count" {
  description = "The desired number of tasks to run"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "The subnets to associate with the ECS service"
  type        = list(string)
}

variable "security_groups" {
  description = "The security groups to associate with the ECS service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the ECS service tasks"
  type        = bool
  default     = false
}


variable "cloud_map_service_arn" {
  description = "The ARN of the Cloud Map service"
  type        = string
}

# variable "cloud_map_service_port" {
#   description = "The port on which the Cloud Map service is listening"
#   type        = number
# }
