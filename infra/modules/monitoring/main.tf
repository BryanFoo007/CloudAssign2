resource "aws_sns_topic" "alerts" {
  name = "${var.name_prefix}-alerts"

  tags = {
    Name = "${var.name_prefix}-alerts"
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "${var.name_prefix}-asg-high-cpu"
  alarm_description   = "Average CPU utilization of the application ASG is above the configured threshold."

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"

  period    = var.period_seconds
  statistic = "Average"
  threshold = var.cpu_alarm_threshold

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]
}