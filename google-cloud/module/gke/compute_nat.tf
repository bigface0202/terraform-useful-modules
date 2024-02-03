resource "google_compute_router_nat" "router_nat" {
  project = var.project_id
  name    = "${var.name}-router-nat"
  router  = google_compute_router.gke-router.name
  region  = var.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [
    google_compute_address.nat_address.self_link
  ]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = google_compute_subnetwork.k8s-pri.id
    source_ip_ranges_to_nat = [
      "PRIMARY_IP_RANGE",
      "LIST_OF_SECONDARY_IP_RANGES"
    ]
    secondary_ip_range_names = [
      google_compute_subnetwork.k8s-pri.secondary_ip_range[0].range_name,
      google_compute_subnetwork.k8s-pri.secondary_ip_range[1].range_name,
    ]
  }
}
