# Terraform Module: cloud-storage-monitoring
Basic module to monitor object count in buckets.

```terraform
module "cloud_storage_monitor" {
  source = "./modules/cloud-storage-monitoring"

  name       = "storage-monitor-v1"
  bucket_paths = [
    "<BUCKET>/some/folder",
  ]
  cron_schedule         = "*/30 * * * *"
  cron_time_zone        = "Australia/Melbourne"
  region                = "us-east1"
  threshold             = "1000"
  timeout               = "7200s"
  service_account       = data.google_compute_default_service_account.default.email
  notification_channels = [
    # Add notification channel ids here
  ]
}

data "google_compute_default_service_account" "default" {}

data "google_project" "current" {}
```