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

variable "sns_topic_name" {
  description = "Name for the SNS topic"
  type        = string
}

variable "sns_email" {
  description = "Email address for alarm notifications"
  type        = string
}
