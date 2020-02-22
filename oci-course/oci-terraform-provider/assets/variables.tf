# https://www.terraform.io/docs/configuration/providers.html
# https://www.terraform.io/docs/providers/oci/index.html

provider "oci" {
 
}


variable "tags" {
  type = map(string)
  default = {
    "CreatedFor" = "KatacodaLab"
  }
}