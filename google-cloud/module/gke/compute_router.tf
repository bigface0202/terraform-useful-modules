resource "google_compute_router" "gke-router" {
  project = var.project_id
  name    = "${var.name}-router"
  region  = var.region
  network = var.network
}
