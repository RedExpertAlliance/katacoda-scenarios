variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_id" {}

variable "tags" {
  type = "map"
  default = {
    "CreatedFor" = "KatacodaLab"
  }
}