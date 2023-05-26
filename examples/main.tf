module "cloud_storage_monitor" {
  source = "./modules/cloud-storage-monitoring"

  name       = "storage-monitor-v1"
  bucket_paths = [
    "my-bucket-a/some/folder",
    "my-bucket-b/path/to/folder",
    "my-bucket-c",
  ]
  cron_schedule         = "*/30 * * * *"
  cron_time_zone        = "Australia/Melbourne"
  region                = "us-east1"
  threshold             = "1000"
  timeout               = "7200s"
  service_account       = "<EMAIL>"
  notification_channels = [
    google_monitoring_notification_channel.email.id
  ]
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "Test Notification Channel"
  type         = "email"
  labels = {
    email_address = "fake_email@blahblah.com"
  }
  force_delete = false
}