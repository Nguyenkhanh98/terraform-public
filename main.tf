

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = list(string)
}



variable "availability_zones" {
  description = "List of availability zones corresponding to private subnets"
  type        = list(string)
}


variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "public-cluster"
}



variable "onairdomain" {
  description = "Domain for onair"
  type        = string
  default     = "onair.today"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "sad"

}

variable "alb_sg_id" {
  description = "Security group for ALB"
  type        = string
}
