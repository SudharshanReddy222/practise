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
      instance_type   = "t3.medium"
      desired_capacity = 2
      max_size        = 3
      min_size        = 1
      key_name        = "terraform-key"
    }
  }
}


