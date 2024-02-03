# module "my-nat" {
#   source      = "./module/cloud_nat"
#   project_id  = google_project.project_one.project_id
#   region      = "asia-northeast1"
#   nat_name    = "my-nat"
#   router_name = "my-router"
#   subnet      = google_compute_subnetwork.my_subnet.self_link
#   network     = google_compute_network.vpc_network.self_link
# }
