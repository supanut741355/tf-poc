resource "null_resource" "upload_model_to_vertex" {
  provisioner "local-exec" {
    command = <<-EOT
      gcloud ai models upload \
        --region=${var.region} \
        --display-name=${var.display_name} \
        --container-image-uri=${var.container_image_uri} \
        --artifact-uri=${var.artifact_uri} \
        --container-ports=${join(",", var.container_ports)} \
        --container-health-route=${var.container_health_route} \
        --container-command=${join(" ", var.container_command)} \
        --container-args='[${join(",", [for a in var.container_args : "\"${a}\""])}]'
    EOT

    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    region               = var.region
    display_name         = var.display_name
    container_image_uri  = var.container_image_uri
    artifact_uri         = var.artifact_uri
    container_ports      = join(",", var.container_ports)
    container_health     = var.container_health_route
    container_command    = join(" ", var.container_command)
    container_args       = join(" ", var.container_args)
  }
}
