# module "my-nat" {
#   source      = "./module/private_sql"
#   project_id  = google_project.project_one.project_id
#   vpc         = "asia-northeast1"
#   subnet      = google_compute_subnetwork.my_subnet.self_link
#   region      = "asia-northeast1"
# }
