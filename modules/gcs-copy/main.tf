provider "google" {
  alias       = "source"
  project     = var.source_project
  region      = var.region
  credentials = file(var.source_credentials)
}

provider "google" {
  alias       = "target"
  project     = var.target_project
  region      = var.region
  credentials = file(var.target_credentials)
}

resource "null_resource" "copy_folder_files" {
  provisioner "local-exec" {
    command = <<EOT
      gsutil -m cp -r gs://${var.source_bucket}/${var.source_subfolder} gs://${var.target_bucket}/${var.target_subfolder}
    EOT
    environment = {
      GOOGLE_APPLICATION_CREDENTIALS = var.target_credentials
    }
  }
}