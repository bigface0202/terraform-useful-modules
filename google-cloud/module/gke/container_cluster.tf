resource "google_container_cluster" "my_gke" {
  project                   = var.project_id
  name                      = "${var.name}-cluster"
  location                  = var.region
  remove_default_node_pool  = true
  initial_node_count        = 1
  networking_mode           = "VPC_NATIVE"
  default_max_pods_per_node = 32

  network    = var.network
  subnetwork = google_compute_subnetwork.k8s-pri.id

  min_master_version = var.min_master_version
  enable_legacy_abac = false
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  release_channel {
    channel = "STABLE"
  }
  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.k8s-pri.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.k8s-pri.secondary_ip_range[1].range_name
  }

  # master_authorized_networks_config {
  #   // enable_private_endpoint = trueの場合は内部IPにする
  #   cidr_blocks {
  #     cidr_block   = var.authorized_ip
  #     display_name = var.authorized_ip_display_name
  #   }
  # }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "192.168.64.0/28"
    master_global_access_config {
      enabled = true
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  datapath_provider = "ADVANCED_DATAPATH"

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = true
    }
  }
}

resource "google_container_node_pool" "my_node_pool" {
  count             = var.node_pool ? 1 : 0
  project           = var.project_id
  name              = "${var.name}-node-pool"
  location          = var.region
  cluster           = google_container_cluster.my_gke.name
  node_count        = 1
  max_pods_per_node = 32


  # dynamic "autoscaling" {
  #   for_each = terraform.workspace == "prd" ? [1] : []

  #   content {
  #     min_node_count = 1
  #     max_node_count = 2
  #   }
  # }
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type    = "n1-standard-1"
    disk_size_gb    = 50
    image_type      = "COS_CONTAINERD"
    spot            = true
    service_account = google_service_account.gke-practice.email
    oauth_scopes = [
      "cloud-platform"
    ]
  }
}
