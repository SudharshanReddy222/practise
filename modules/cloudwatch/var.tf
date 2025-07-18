variable "alarm_name" {
  description = "Name of the CloudWatch alarm"
  type        = string
}

variable "threshold" {
  description = "CPU utilization percentage to trigger the alarm"
  type        = number
}

variable "instance_id" {
  description = "EC2 Instance ID to monitor"
  type        = string
}

variable "alarm_actions" {
  description = "List of actions (SNS topic ARNs) to invoke when alarm is triggered"
  type        = list(string)
}

variable "ok_actions" {
  description = "List of actions (SNS topic ARNs) to invoke when alarm returns to OK"
  type        = list(string)
}
variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "nodegroup_name" {
  description = "EKS Node Group name"
  type        = string
}
