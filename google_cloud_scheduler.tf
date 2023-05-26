resource "google_cloud_scheduler_job" "monitor" {
  for_each = local.bucket_paths

  name             = format("%s-%s", var.name, each.key)
  description      = format("monitoring %s", each.value)
  schedule         = var.cron_schedule
  time_zone        = var.cron_time_zone
  attempt_deadline = "320s"
  region           = var.region

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri = format(
      "https://cloudbuild.googleapis.com/v1/projects/%s/locations/%s/triggers/%s:run",
      data.google_project.current.project_id,
      google_cloudbuild_trigger.monitor[each.key].location,
      google_cloudbuild_trigger.monitor[each.key].trigger_id,
    )
    oauth_token {
      service_account_email = data.google_service_account.current.email
    }

    body = base64encode("")
  }
}