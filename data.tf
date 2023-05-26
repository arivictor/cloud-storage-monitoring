data "google_service_account" "current" {
  account_id = var.service_account
}

data "google_project" "current" {}