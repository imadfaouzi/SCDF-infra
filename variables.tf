variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "AccountID" {
  description = "my account id"
  default = "339713000514"
}
//-----------------------------------------------------------------------
// BACKEND S3
variable "s3-tfstate-bucketName" {
  description = "the name of s3 bucket containning tfstate"
  default = "scdf-statefile-bucket"
}

variable "s3-tfstate-lockDB" {
  description = "the lockState DB name  of s3 bucket containning tfstate"
  default = "scdf-statefile-db"
}

