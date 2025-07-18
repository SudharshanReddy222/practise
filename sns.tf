resource "aws_sns_topic" "alarm_topic" {
  name = "cpu-util-alarm-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = "var.sns_email"  # Replace with your email address
}
