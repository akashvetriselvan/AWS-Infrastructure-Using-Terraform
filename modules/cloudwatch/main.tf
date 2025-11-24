# Create SNS Topic for notifications
resource "aws_sns_topic" "alarm_topic" {
  name = "${var.project}-alarm-topic"
}

# Subscribe your email to SNS topic
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

# Create a CloudWatch alarm for EC2 CPU Utilization
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "${var.project}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"              # 2-minute interval
  statistic           = "Average"
  threshold           = "70"               # Alert if >70% CPU
  alarm_description   = "Alert when EC2 CPU usage exceeds 70%"
  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]

  tags = {
    Name = "${var.project}-cpu-alarm"
  }
}
