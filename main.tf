terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "myorder-beta"
  region  = "var.region"
  zone    = "asia-southeast1-a"
}

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }

# resource "google_compute_instance" "vm_instance" {
#   name         = "terraform-instance"
#   machine_type = "f1-micro"
#   tags         = ["web", "dev"]

#   boot_disk {
#     initialize_params {
#       image = "cos-cloud/cos-stable"
#     }
#   }

#   network_interface {
#     network = google_compute_network.vpc_network.name
#     access_config {
#     }
#   }
# }

module "gcs_copy" {
  source = "./modules/gcs-copy"

  source_project     = "myorder-research-101"
  source_bucket      = "tmp-model-ai"
  source_subfolder   = "gliner_triton_server/30_09_2025"
  source_credentials = "./modules/gcs-copy/credentails/myorder-research-101-246837526cba.json"

  target_project     = "myorder-research-101"
  target_bucket      = "tmp-model-ai-beta"
  target_subfolder   = "gliner_triton_server"
  target_credentials = "./modules/gcs-copy/credentails/myorder-beta-17d274fdd06f.json"
}