variable "namespace_name" {
  description = "The name of the Cloud Map namespace."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID for the private DNS namespace."
  type        = string
  default     = null
}

variable "description" {
  description = "A description for the Cloud Map namespace."
  type        = string
  default     = ""
}


