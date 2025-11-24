variable "project" {
  description = "Project name for tagging"
}

variable "instance_id" {
  description = "EC2 instance ID to monitor"
}

variable "alarm_email" {
  description = "Email to receive CloudWatch notifications"
}
