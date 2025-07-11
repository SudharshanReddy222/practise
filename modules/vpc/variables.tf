variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
}
variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}
variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
}
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
