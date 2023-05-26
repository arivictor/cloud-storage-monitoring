variable "bucket_paths" {
  type        = list(string)
  description = "list of bucket paths"
}

variable "region" {
  type        = string
  description = "deployment region (e.g. asia-east1, us-east1)"

  validation {
    condition = !contains(
      ["global"],
      var.region
    )
    error_message = "Err: region '${var.region}' is not supported."
  }
}

variable "notification_channels" {
  type        = list(string)
  description = "notication channel ids (['projects/[PROJECT_ID]/notificationChannels/[CHANNEL_ID]'])"
}

variable "name" {
  type        = string
  description = "service name"
}

variable "cron_schedule" {
  type        = string
  description = "cron schedule (e.g. * * * * *)"
}

variable "cron_time_zone" {
  type        = string
  description = "cron time zone (e.g. Australia/Melbourne)"
}

variable "threshold" {
  type        = string
  description = "object threshold before log is created"
}

variable "timeout" {
  type        = string
  description = "timeout before build fails (e.g. 300s, 7200s)"
}

variable "service_account" {
  type        = string
  description = "service account email"
}