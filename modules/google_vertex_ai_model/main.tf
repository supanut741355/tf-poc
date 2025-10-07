# resource "null_resource" "upload_model_to_vertex" {
#   provisioner "local-exec" {
#     command = <<-EOT
#       gcloud ai models upload \
#         --region=${var.region} \
#         --display-name=${var.display_name} \
#         --container-image-uri=${var.container_image_uri} \
#         --artifact-uri=${var.artifact_uri} \
#         --container-ports=${join(",", var.container_ports)} \
#         --container-health-route=${var.container_health_route} \
#         --container-command=${join(" ", var.container_command)} \
#         --container-args='[${join(",", [for a in var.container_args : "\"${a}\""])}]'
#     EOT

#     interpreter = ["/bin/bash", "-c"]
#   }

#   triggers = {
#     region               = var.region
#     display_name         = var.display_name
#     container_image_uri  = var.container_image_uri
#     artifact_uri         = var.artifact_uri
#     container_ports      = join(",", var.container_ports)
#     container_health     = var.container_health_route
#     container_command    = join(" ", var.container_command)
#     container_args       = join(" ", var.container_args)
#   }
# }



resource "google_vertex_ai_model" "model" {
  # for_each    = { for model in var.genai_models : model.name => model }
  
  name        = each.value.name
  project     = var.project_id
  region      = var.region
  display_name = "${each.value.name}-${each.value.version}"
  description = "GenAI ${each.value.type} model - ${each.value.name}"
  
  # For public pre-trained models
  parent_model = each.value.type == "text" ? "projects/${var.project_id}/locations/${var.region}/models/text-bison@${each.value.version}" : "projects/${var.project_id}/locations/${var.region}/models/gemini-pro@${each.value.version}"
  
  encryption_spec {
    kms_key_name = var.kms_key_name
  }
}