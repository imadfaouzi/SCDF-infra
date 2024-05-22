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

variable "instance_discovery" {
  description = "The instance discovery method to use. Options are 'API calls', 'API calls and DNS queries in VPCs', 'API calls and public DNS queries'."
  type        = string
  default     = "API calls"
}
