resource "google_service_account_iam_binding" "workload_identity_binding" {
  service_account_id = google_service_account.external-secrets.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[external-secrets/sec-mng]"
  ]
}
