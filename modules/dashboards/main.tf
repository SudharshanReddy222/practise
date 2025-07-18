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
