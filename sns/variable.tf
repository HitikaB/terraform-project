variable "sns_topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "sns_topic_subscription_protocol" {
  description = "Protocol for SNS subscription"
  type        = string
}

variable "sns_topic_subscription_endpoint" {
  description = "Endpoint for SNS subscription"
  type        = string
}