variable "domain_name" {
  description = "Domain name to  create a hosted zone"
}

variable "ttl" {
  description = "TTL in seconds"
}

variable "alb_dns_name" {
  description = "ALB Alias for records"
}

variable "zone_id" {
  description = "ALB hosted zone ID"
}

variable "record_type" {
  description = "Record Type"
  default = "A"
}