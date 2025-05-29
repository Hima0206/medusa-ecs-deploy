variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones to use for the public subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "medusa-cluster"
}

variable "ecs_service_name" {
  description = "name of ecs service"
  type        = string
  default     = "medusa-service"
}

variable "ecs_task_cpu" {
  description = "CPU units for the ECS task"
  type        = string
  default     = "256"
}

variable "ecs_task_memory" {
  description = "Memory in MiB for the ECS task"
  type        = string
  default     = "512"
}

variable "container_name" {
  description = "container name"
  type        = string
  default     = "medusa-container"
}

variable "containerPort" {
  description = "Port on which the container listens"
  type        = number
  default     = 9000
}

variable "ecr_image_url" {
  description = "ECR image URI for the ECS task"
  type        = string
}




