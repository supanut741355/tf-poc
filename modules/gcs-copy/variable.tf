# variable "source_project" {}
# variable "source_bucket" {}
# variable "source_files" {
#   type = list(string)
# }
# variable "source_credentials" {}

# variable "target_project" {}
# variable "target_bucket" {}
# variable "target_credentials" {}

# # variable "project" { }

# variable "region" {
#   default = "asia-southeast1"
# }

# variable "zone" {
#   default = "asia-southeast1-a"
# }


variable "source_project" {}
variable "source_bucket" {}
variable "source_subfolder" {
  description = "Subfolder path ใน bucket ต้นทาง เช่น data/subfolder"
}
variable "source_credentials" {}

variable "target_project" {}
variable "target_bucket" {}
variable "target_subfolder" {}
variable "target_credentials" {}
