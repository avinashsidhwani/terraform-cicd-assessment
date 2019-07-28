resource "aws_security_group" "av_rds_sg" {
  name        = var.rds_sg["name"]
  description = var.rds_sg["desc"]
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, var.rds_sg_tags)
}
resource "aws_security_group_rule" "ingress_sg" {
  count = length(var.rds_ingress_sg)

  type              = "ingress"
  security_group_id = aws_security_group.av_rds_sg.id

  from_port                = var.rds_ingress_sg[count.index]["port"]
  to_port                  = var.rds_ingress_sg[count.index]["port"]
  protocol                 = var.rds_ingress_sg[count.index]["protocol"]
  source_security_group_id = var.rds_ingress_sg[count.index]["source_security_group_id"]
}




/*resource "aws_security_group" "av_rds_sg" {
  name        = ""
  description = ""
  # diff
  vpc_id = "${aws_vpc.av_vpc.id}"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.av_ec2_pvt_sg.id}"]
  }

  tags = {
    Name    = ""
    project = "PE-Training"
    module  = "terraform"
  }
}*/
