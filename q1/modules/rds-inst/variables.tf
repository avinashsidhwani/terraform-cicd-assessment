# =============== global ===============
/*variable "region" {
  type = "string"
}*/
variable "common_tags" {
  type = "map"
}
variable "vpc_id" {
  type = "string"
}
variable "db_subnet_ids" {
  type = "list"
}


# =============== local ===============

# ======= rds security groups =======
variable "rds_sg" {
  type = "map"
}
variable "rds_sg_tags" {
  type = "map"
}
variable "rds_ingress_sg" {
  type = "list"
}


# ======= rds db subnet group =======
variable "db_subnet_grp_name" {
  type = "string"
}
variable "db_subnet_grp_tags" {
  type = "map"
}


# ======= rds instance =======
variable "rds_inst" {
  type = "map"
}
variable "rds_inst_alloc_storage" {
  type = number
}
# variable "rds_inst_security_group_ids" {
#   type = "map"
# }
