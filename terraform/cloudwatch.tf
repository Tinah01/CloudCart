resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/${var.project}/app"
  retention_in_days = 14
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project}-high-cpu"
  alarm_description   = "Alarm if ASG average CPU > 70% for 5 minutes"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 1
  threshold           = 70
  comparison_operator = "GreaterThanThreshold"
  dimensions          = { AutoScalingGroupName = aws_autoscaling_group.asg.name }
  alarm_actions       = [] # add SNS topic ARN if you want notifications
}
