
resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.threshold
  alarm_description   = "Alarm for high CPU utilization"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  dimensions = {
    InstanceId = var.instance_id
  }
  unit = "Percent"
