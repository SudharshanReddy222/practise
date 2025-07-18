
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
}
resource "aws_cloudwatch_dashboard" "eks_nodegroup_dashboard" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x    = 0,
        y    = 0,
        width = 12,
        height = 6,
        properties = {
          title  = "NodeGroup CPU Utilization"
          view   = "timeSeries"
          region = var.region
          metrics = [
            [ "ContainerInsights", "CPUUtilization", "ClusterName", var.cluster_name, "NodeGroupName", var.nodegroup_name ]
          ]
          stat   = "Average"
          period = 300
        }
      },
      {
        type = "metric",
        x    = 0,
        y    = 6,
        width = 12,
        height = 6,
        properties = {
          title  = "NodeGroup Memory Utilization"
          view   = "timeSeries"
          region = var.region
          metrics = [
            [ "ContainerInsights", "MemoryUtilization", "ClusterName", var.cluster_name, "NodeGroupName", var.nodegroup_name ]
          ]
          stat   = "Average"
          period = 300
        }
      }
    ]
  })
}
