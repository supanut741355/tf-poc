variable "endpoint_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "model_id" {
  type        = string
}

variable "display_name" {
  type        = string
}

variable "traffic_split" {
  type        = string
  default     = "0=100"
}

variable "machine_type" {
  type        = string
  default     = "n1-standard-4"
}

variable "accelerator_type" {
  type        = string
  default     = null
}

variable "accelerator_count" {
  type        = number
  default     = 0
}

variable "max_replica_count" {
  type        = number
  default     = 1
}

variable "min_replica_count" {
  type        = number
  default     = 1
}
