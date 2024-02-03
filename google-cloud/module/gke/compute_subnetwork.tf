resource "google_compute_subnetwork" "k8s-pri" {
  name                     = "${var.name}-subnet-pri"
  project                  = var.project_id
  region                   = var.region
  network                  = var.network
  ip_cidr_range            = "172.16.0.0/24"
  private_ip_google_access = true

  secondary_ip_range = [
    {
      range_name    = "gke-pods-ip-range"
      ip_cidr_range = "192.168.1.0/24"
    },
    {
      range_name    = "gke-service-ip-range"
      ip_cidr_range = "192.168.2.0/24"
    }
  ]
}
