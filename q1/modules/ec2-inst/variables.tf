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
variable "subnet_ids" {
  type = "list"
}
variable "rds_endpoint" {
  type = "string"
}
variable "rds_usr" {
  type = "string"
}
variable "rds_pwd" {
  type = "string"
}
variable "rds_dbname" {
  type = "string"
}


# =============== local ===============

# ======= ec2 security groups =======
variable "ec2_sg" {
  type = "list"
}
variable "ec2_sg_tags" {
  type = "list"
}

variable "ingress_cidr" {
  type = "list"
}
variable "ingress_sg" {
  type = "list"
}
variable "egress_cidr" {
  type = "list"
}
variable "egress_sg" {
  type = "list"
}



# ======= ec2 instance =======
# variable "ec2_inst" {
#   type = "list"
# }
variable "ec2_inst_amis" {
  type = "list"
}
variable "ec2_inst_types" {
  type = "list"
}
variable "ec2_inst_pub_ip" {
  type = "list"
}
variable "ec2_inst_tags" {
  type = "list"
}
variable "ec2_inst_subnet_nos" {
  type = "list"
}
variable "ec2_inst_sg_nos" {
  type = "list"
}
variable "ec2_inst_keynames" {
  type = "list"
}
variable "ec2_inst_has_userdata" {
  type = "list"
}
variable "ec2_inst_userdata_file" {
  type = "list"
}

data "template_file" "userdata" {
  count = length(var.ec2_inst_userdata_file)

  template = "${file(var.ec2_inst_userdata_file[count.index])}"
  vars = {
    rds_endpoint = var.rds_endpoint
    rds_usr      = var.rds_usr
    rds_pwd      = var.rds_pwd
    rds_dbname   = var.rds_dbname
  }
}
