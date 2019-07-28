/*locals {
  common_tags = {
    email_id = "avinash.sidhwani@quantiphi.com",
    project_name = "PE-Training",
    module_name = "terraform"
  }
}*/
variable "region" {
  type = "string"
}
variable "common_tags" {
  type = "map"
}
variable "db_usr" {
  type = "string"
}
variable "db_pwd" {
  type = "string"
}
variable "db_name" {
  type = "string"
}
