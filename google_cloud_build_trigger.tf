resource "google_cloudbuild_trigger" "monitor" {
  for_each = local.bucket_paths

  name            = format("%s-%s", var.name, each.key)
  description     = format("monitoring %s", each.value)
  location        = var.region
  disabled        = false
  tags            = ["monitoring", "storage"]
  service_account = data.google_service_account.current.id

  build {
    timeout = var.timeout
    substitutions = {
      _BUCKET_PATHS : "${each.key}"
      _ALERT_THRESHOLD : var.threshold
      _CLOUD_LOGGING_SEVERITY : "WARNING"
      _SERVICE_NAME : var.name
    }

    step {
      name       = "gcr.io/cloud-builders/gsutil"
      entrypoint = "bash"
      args = [
        "-c",
        file("${path.module}/script.sh")
      ]
    }

    options {
      substitution_option   = "ALLOW_LOOSE"
      dynamic_substitutions = true
      logging               = "CLOUD_LOGGING_ONLY"
    }
  }

  # Required but can be left blank
  trigger_template {
    branch_name = ""
    repo_name   = ""
  }
}