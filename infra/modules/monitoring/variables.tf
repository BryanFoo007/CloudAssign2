variable "name_prefix" {
  type = string
}

variable "alert_email" {
  description = "Email address that receives SNS alert notifications."
  type        = string
}

variable "asg_name" {
  type = string
}

variable "cpu_alarm_threshold" {
  type    = number
  default = 80
}

variable "period_seconds" {
  type    = number
  default = 300
}

variable "evaluation_periods" {
  type    = number
  default = 2
}