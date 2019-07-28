# ======= rds instance =======
# resource "aws_db_parameter_group" "av_db_pg" {
#   name   = "av-t-a1"
#   family = "mysql5.7"

#   parameter {
#     name  = "log_bin_trust_function_creators"
#     value = "1"
#   }
# }

resource "aws_db_instance" "av_rds" {
  allocated_storage    = var.rds_inst_alloc_storage
  engine               = var.rds_inst["engine"]
  engine_version       = var.rds_inst["engine_version"]
  instance_class       = var.rds_inst["instance_class"]
  name                 = var.rds_inst["name"]
  username             = var.rds_inst["username"]
  password             = var.rds_inst["password"]
  db_subnet_group_name = var.rds_inst["db_subnet_grp"]
  # vpc_security_group_ids = [var.rds_inst_security_group_ids]
  vpc_security_group_ids = ["${aws_security_group.av_rds_sg.id}"]

  skip_final_snapshot = tobool(var.rds_inst["skip_final_snapshot"])
  # parameter_group_name = "${aws_db_parameter_group.av_db_pg.id}"
}





/*resource "aws_db_instance" "av_rds" {
  allocated_storage = 20
  engine = "mysql"
  engine_version = "5.7.22"
  instance_class = "db.t2.micro"
  name = "av_t_rds"
  username = "av_t_rds_usr"
  password = "av_t_rds_pwd"
  # diff
  db_subnet_group_name = "${aws_db_subnet_group.av_rds_sub_grp.id}"
  vpc_security_group_ids = ["${aws_security_group.av_rds_sg.id}"]
}*/
