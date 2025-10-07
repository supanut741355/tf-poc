terraform {
  required_providers {
    # google = {
    #   source  = "hashicorp/google"
    #   version = "6.8.0"
    # }
    google = {
      source  = "hashicorp/google"
      version = ">= 4.80.0, < 5.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.80.0, < 5.0.0"
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

  source_project     = "myorder-ai-lab-research"
  source_bucket      = "poc-model-serving-asia"
  # source_subfolder   = "triton-onnx/2025-09-16"
  source_subfolder   = "triton-onnx/2025-10-02-tmp-2"
  source_credentials = "./modules/gcs-copy/credentails/myorder-ai-lab-research-a52ee0a1943a.json"

  target_project     = "myorder-ai-model-serving"
  target_bucket      = "poc-model-ai"
  # target_subfolder   = "gliner_triton_server/2025-09-16"
  target_subfolder   = "gliner_triton_server/2025-10-02-tmp-2"
  target_credentials = "./modules/gcs-copy/credentails/myorder-ai-model-serving-6b5d25e28b2b.json"
}

module "upload_model_to_vertex" {
  source = "./modules/google_vertex_ai_model"
  region              = "asia-southeast1"
  display_name        = "triton-onnx-poc-by-nutx"
  container_image_uri = "asia-southeast1-docker.pkg.dev/myorder-ai-model-serving/triton-server/tritonserver:latest"
  artifact_uri        = "gs://poc-model-ai/gliner_triton_server/2025-09-16"
}

module "make_vertex_ai_endpoint" {
  source       = "./modules/google_vertex_ai_endpoint"
  region       = "asia-southeast1"
  display_name = "triton-endpoint-poc-by-nutx"
}