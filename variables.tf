variable "bucket_paths" {
  type        = list(string)
  description = "list of bucket paths"

  validation {
    condition     = length(var.bucket_paths) >= 1
    error_message = "length of 'bucket_paths' cannot be 0"
  }
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

  validation {
    condition     = can(regex("^[_a-zA-Z0-9-]+$", var.name))
    error_message = "Invalid value for 'name'. Only alphanumeric characters, underscores, and hyphens are allowed."
  }
}

variable "cron_schedule" {
  type        = string
  description = "cron schedule (e.g. * * * * *)"
}

variable "cron_time_zone" {
  type        = string
  description = "cron time zone (e.g. Australia/Melbourne)"

  validation {
    condition     = can(regex("^[a-zA-Z_]+\\/[a-zA-Z_]+$", var.cron_time_zone))
    error_message = "Invalid value for 'cron_time_zone'. Must be a valid time zone pattern (e.g., <country>/<city>)."
  }
}

variable "threshold" {
  type        = string
  description = "object threshold before log is created"

  validation {
    condition     = can(regex("^\\d+$", var.threshold))
    error_message = "Invalid value for 'threshold'. Must be a string number."
  }
}

variable "timeout" {
  type        = string
  description = "timeout before build fails (e.g. 300s, 7200s)"

  validation {
    condition     = can(regex("^\\d+s$", var.timeout))
    error_message = "Invalid value for 'timeout'. Must be a number followed by 's' (e.g., '1000s')."
  }
}

variable "service_account" {
  type        = string
  description = "service account email"

  validation {
    condition     = can(regex("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", var.service_account))
    error_message = "Invalid value for 'service_account'. Must be a valid email address."
  }
}