resource "aws_cloudwatch_metric_alarm" "eks_cpu_utilization" {
  alarm_name          = "eks-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when CPU utilization exceeds 80% for 2 datapoints within 5 minutes"
  alarm_actions       = [aws_sns_topic.eks_notifications.arn]

  dimensions = {
    ClusterName = aws_eks_cluster.eks_cluster.name
  }
}

resource "aws_sns_topic" "eks_notifications" {
  name = "eks-notifications"
}

resource "aws_sns_topic_subscription" "eks_notification_subscription" {
  topic_arn = aws_sns_topic.eks_notifications.arn
  protocol  = "email"
  endpoint  = "gonuguntla.sahichowdary@sasken.com" // Change this to your email address
}


resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization" {
  alarm_name          = "rds-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when CPU utilization exceeds 80% for 2 datapoints within 5 minutes"
  alarm_actions       = [aws_sns_topic.rds_notifications.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.my_rds_instance.id
  }
}

resource "aws_sns_topic" "rds_notifications" {
  name = "rds-notifications"
}

resource "aws_sns_topic_subscription" "rds_notification_subscription" {
  topic_arn = aws_sns_topic.rds_notifications.arn
  protocol  = "email"
  endpoint  = "gonuguntla.sahichowdary@sasken.com" // Change this to your email address
}


resource "aws_cloudwatch_metric_alarm" "elb_http_5xx_errors" {
  alarm_name          = "elb-http-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_Backend_5XX"
  namespace           = "AWS/ELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Alarm when HTTP 5xx errors exceed 10 for 2 datapoints within 5 minutes"
  alarm_actions       = [aws_sns_topic.elb_notifications.arn]

  dimensions = {
    LoadBalancerName = aws_lb.my_elb.name
  }
}

resource "aws_sns_topic" "elb_notifications" {
  name = "elb-notifications"
}

resource "aws_sns_topic_subscription" "elb_notification_subscription" {
  topic_arn = aws_sns_topic.elb_notifications.arn
  protocol  = "email"
  endpoint  = "gonuguntla.sahichowdary@sasken.com" // Change this to your email address
}

