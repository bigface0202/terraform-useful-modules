resource "google_service_account" "gke-practice" {
  project      = var.project_id
  account_id   = "${var.name}-sa"
  display_name = "Service account for practicing gke"
}

resource "google_service_account" "external-secrets" {
  project      = var.project_id
  account_id   = "${var.name}-external-secrets-sa"
  display_name = "Service account for external secrets"
}
