
variable "region" {
  description = "The AWS region where the S3 bucket should be created."
}

variable "cf_restriction_locations" {
  description = "List of locations for geo-restriction"
  type        = list(string)
}

variable "origin_endpoint" {
  description = "Origins domain name"
}

variable "aliases" {
  description = "Alternative domain name for cdn"
}

variable "cert_arn" {
  description = "ACM certificate ARN"
}
