resource "null_resource" "vertext_ai_endpoint" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud ai endpoints create \
        --region=${var.region} \
        --display-name=${var.display_name} \
        --format="value(name)"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    region        = var.region
    display_name  = var.display_name
  }
}
