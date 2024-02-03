resource "google_compute_router" "router_bastion" {
  project = var.project_id
  name    = var.router_name #TODO
  region  = var.region
  network = var.network
}
