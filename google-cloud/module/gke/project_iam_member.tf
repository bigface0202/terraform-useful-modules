resource "google_project_iam_member" "gke" {
  for_each = toset([
    "roles/artifactregistry.reader",
    "roles/monitoring.admin",
    "roles/logging.admin",
    "roles/storage.admin",
    "roles/pubsub.admin",
    "roles/pubsub.subscriber",
    "roles/cloudsql.admin",
  ])
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke-practice.email}"
}

resource "google_project_iam_member" "external-secrets" {
  for_each = toset([
    "roles/secretmanager.secretAccessor",
  ])
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.external-secrets.email}"
}
