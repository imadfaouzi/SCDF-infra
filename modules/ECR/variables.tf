variable "account_id" {
  description = "The AWS account ID where the ECR repository will be created"
  type        = string
}

variable "region" {
  description = "The AWS region where the ECR repository will be created"
  type        = string
}

variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "tag" {
  description = "The tag for the Docker image"
  type        = string
}


// NOT REQUIRED : 
variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned on push"
  type        = bool
  default     = true
}

variable "is_public" {
  description = "Whether the ECR repository should be public"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the repository"
  type        = map(string)
  default     = {}
}
