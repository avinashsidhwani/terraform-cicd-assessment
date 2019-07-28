
resource "aws_db_subnet_group" "av_rds_sub_grp" {
  name       = var.db_subnet_grp_name
  subnet_ids = var.db_subnet_ids

  tags = merge(var.common_tags, var.db_subnet_grp_tags)
}



/*resource "aws_db_subnet_group" "av_rds_sub_grp" {
  name       = "av-t-rds-sub-grp"
  subnet_ids = ["${aws_subnet.av_pvt_subnet2.id}", "${aws_subnet.av_pvt_subnet3.id}"]

  tags = {
    Name    = "av-t-rds-sub-grp"
    project = "PE-Training"
    module  = "terraform"
  }
}*/
