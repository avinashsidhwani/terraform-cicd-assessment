# =============== global ===============
variable "region" {
  type = "string"
}
variable "common_tags" {
  type = "map"
}


# =============== local ===============

# ======= vpc and subnets =======
variable "vpc_tags" {
  type = "map"
}
variable "vpc_cidr" {
  type = "string"
}

/*variable "subnet" {
  type = "list"
}*/
variable "subnets" {
  type = "list"
}
variable "subnet_tags" {
  type = "list"
}
variable "subnet_cidrs" {
  type = "list"
}
variable "subnet_azs" {
  type = "list"
}
variable "subnet_db_grp" {
  type = "list"
}

# ======= gateways =======
variable "igw_tags" {
  type = "map"
}
variable "natgw_alloc_id" {
  type = "string"
}
variable "natgw_tags" {
  type = "map"
}
