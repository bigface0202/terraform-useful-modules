# module "gke-module" {
#   source                     = "./module/gke-practice"
#   project_id                 = google_project.project_one.project_id
#   region                     = "asia-northeast1"
#   zone                       = "a"
#   name                       = "test-gke"
#   network                    = google_compute_network.vpc_network.id
#   authorized_ip              = "<YOUR_IP_ADDRESS>"
#   authorized_ip_display_name = "my_home"
#   min_master_version         = "1.27.3-gke.100"
#   node_pool                  = true
# }
