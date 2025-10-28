variable "region" {
  description = "Region where the model is deployed"
  type        = string
}

variable "display_name" {
  description = "Display name of the model"
  type        = string
}

variable "container_image_uri" {
  description = "Container image URI from Artifact Registry"
  type        = string
}

variable "artifact_uri" {
  description = "URI of the model artifacts in Cloud Storage"
  type        = string
}

variable "container_ports" {
  description = "List of container ports"
  type        = list(number)
  default     = [8080]
}

variable "container_health_route" {
  description = "Container health check route"
  type        = string
  default     = "/v2/health/ready"
}

variable "container_command" {
  description = "Command to run inside the container"
  type        = list(string)
  default     = ["/bin/bash"]
}

variable "container_args" {
  description = "Arguments for the container command"
  type        = list(string)
  default     = [
    "-lc",
    "exec tritonserver --model-repository=\"$${AIP_STORAGE_URI}\" --vertex-ai-default-model=gliner --http-port=\"$${AIP_HTTP_PORT:-8080}\" --strict-model-config=false --log-verbose=0"
  ]
}
