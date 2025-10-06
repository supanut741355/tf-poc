resource "google_vertex_ai_model" "this" {
  display_name = var.display_name
  region       = var.region

  container_spec {
    image_uri      = var.container_image_uri
    command        = var.container_command
    args           = var.container_args
    ports          = var.container_ports
    health_route   = var.container_health_route
  }

  artifact_uri = var.artifact_uri

  labels = var.labels
}
