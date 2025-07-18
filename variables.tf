variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
  variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16" 
}
variable "environment" {
  description = "Environment for the EKS cluster (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}
variable "node_groups" {
  description = "Map of node group configurations"
  type = map(object({
    instance_type   = string
    desired_capacity = number
    max_size        = number
    min_size        = number
    key_name        = string
  }))
  default = {
    eks_nodes = {
      instance_type   = "t3.large"
      desired_capacity = 2
      max_size        = 4
      min_size        = 1
      key_name        = "terraform-key"
    }
  }
}
variable "alarm_name" {
  description = "Name of the CloudWatch alarm"
  type        = string
  default     = "HighCPUUtilizationAlarm"
}
variable "threshold" {
  description = "CPU utilization percentage to trigger the alarm"
  type        = number
  default     = 70
}
variable "instance_ids" {
  description = "List of EC2 Instance IDs to monitor"
  type        = list(string)
  default     = ["i-0eee7945e876ef92d" , "i-082707f8b7b9d38e4"]
}
variable "sns_topic_name" {
  description = "Name for the SNS topic"
  type        = string
  default     = "HighCPUUtilizationTopic"
}
variable "sns_email" {
  description = "Email address for alarm notifications"
  type        = string
  default     = "jayavardhanreddy616@gmail.com"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "nodegroup_name" {
  description = "EKS Node Group name"
  type        = string
  default     = "eks_nodes"
}
variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
  default     = "EKSNodeGroupDashboard"
}
