resource "null_resource" "deploy_model" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud ai endpoints deploy-model ${var.endpoint_id} \
        --region=${var.region} \
        --model=${var.model_id} \
        --display-name=${var.display_name} \
        --traffic-split=${var.traffic_split} \
        --machine-type=${var.machine_type} \
        --accelerator=type=${var.accelerator_type},count=${var.accelerator_count} \
        --max-replica-count=${var.max_replica_count} \
        --min-replica-count=${var.min_replica_count}
    EOT

    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    endpoint_id       = var.endpoint_id
    region            = var.region
    model_id          = var.model_id
    display_name      = var.display_name
    traffic_split     = var.traffic_split
    machine_type      = var.machine_type
    accelerator_type  = var.accelerator_type
    accelerator_count = var.accelerator_count
    max_replicas      = var.max_replica_count
    min_replicas      = var.min_replica_count
  }
}
