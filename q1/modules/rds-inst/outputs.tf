output "rds_sg_id" {
  value = "${aws_security_group.av_rds_sg.id}"
}
output "subnet_grp_id" {
  value = "${aws_db_subnet_group.av_rds_sub_grp.id}"
}
output "rds_endpoint" {
  value = "${element(split(":", aws_db_instance.av_rds.endpoint), 0)}"
}
