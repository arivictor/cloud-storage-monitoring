resource "google_monitoring_alert_policy" "object_gt_threshold" {
  display_name          = "(Terraform) Bucket Object Count Greater Than Threshold"
  combiner              = "OR"
  notification_channels = var.notification_channels

  conditions {
    display_name = "Log match condition"
    condition_matched_log {
      filter = <<-EOT
            severity=WARNING
            logName="projects/${data.google_project.current.project_id}/logs/${var.name}"
            jsonPayload.object_count >= ${var.threshold}
        EOT
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "3600s"
    }
    auto_close = "604800s"
  }
}
