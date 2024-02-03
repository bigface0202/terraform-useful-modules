resource "google_compute_router_nat" "nat_bastion" {
  project = var.project_id
  name    = var.nat_name
  router  = google_compute_router.router_bastion.name
  region  = var.region

  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = var.subnet
    source_ip_ranges_to_nat = [
      "ALL_IP_RANGES"
    ]
  }
}
