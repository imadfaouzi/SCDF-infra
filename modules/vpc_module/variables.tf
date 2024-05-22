######################################################
#          VPC ------------------ VRS               #
#####################################################

variable "vpc_name" {
   description = "name of VPC"
   default = "my_vpc"
}

variable "vpc_cidr" {
      description = "vpc cidr"
}

variable "tags" {
  description = "some extra tags"

}

/*
 *  Subnets
 **/

variable "public_subnets" {
  description = "A list of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "A list of availability zones to distribute subnets across"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

