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


variable "container_name" {
  description = "container name"
  type        = string
  default     = "medusa-container"
}

variable "containerPort" {
  description = "Port on which the container listens"
  type        = number
  default     = 5000
}

variable "ecr_image_url" {
  description = "ECR image URI for the ECS task"
  type        = string
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "medusa-repo"
}

variable "s3_bucket_name" {
  description = "S3 bucket name for Medusa file uploads"
  type        = string
  default     = "medusa-files"
}

variable "db_name" {
  description = "Database name for Medusa"
  type        = string
  default     = "medusa_db"
}

variable "db_username" {
  description = "Database username for Medusa"
  type        = string
  default     = "medusa_user"
}

variable "db_password" {
  description = "Database password for Medusa"
  type        = string
  default     = "yourStrongPassword123" # Replace with a secure password or use AWS Secrets Manager
  sensitive   = true
}


variable "db_host" {
  description = "Database host for Medusa"
  type        = string
  default     = "medusa-db.cluster-xxxxxxxxxxxx.us-east-1.rds.amazonaws.com" # Replace with your RDS endpoint
} 

variable "db_port" {
  description = "Database port for Medusa"
  type        = number
  default     = 5432
}

variable "use_secrets_manager" {
  description = "Whether to use AWS Secrets Manager for sensitive data"
  type        = bool
  default     = true        
}









