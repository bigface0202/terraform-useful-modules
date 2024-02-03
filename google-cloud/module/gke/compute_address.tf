resource "google_compute_address" "nat_address" {
  project = var.project_id
  name    = "${var.name}-nat-address"
  region  = var.region
}
