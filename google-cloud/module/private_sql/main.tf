resource "google_compute_global_address" "private_ip_address" {
  project       = var.project_id
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = var.vpc
  address       = "192.168.128.0"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "my_instance" {
  provider         = google-beta
  project          = var.project_id
  name             = "my-instance"
  region           = var.region
  database_version = "MYSQL_5_7"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc
      allocated_ip_range                            = google_service_networking_connection.private_vpc_connection.reserved_peering_ranges[0]
      enable_private_path_for_google_cloud_services = true
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}
