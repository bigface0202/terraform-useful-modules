# module "my-nat" {
#   source      = "./module/private_sql"
#   project_id  = google_project.project_one.project_id
#   vpc         = google_compute_network.vpc_network.id
#   subnet      = google_compute_subnetwork.my_subnet.self_link
#   region      = "asia-northeast1"
# }
