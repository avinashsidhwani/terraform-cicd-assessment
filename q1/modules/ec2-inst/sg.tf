# ======= sg =======
resource "aws_security_group" "av_ec2_sg" {
  count = 2

  name        = var.ec2_sg[count.index]["name"]
  description = var.ec2_sg[count.index]["desc"]
  vpc_id      = var.vpc_id
  #vpc_id      = var.vpc_id

  tags = merge(var.common_tags, var.ec2_sg_tags[count.index])
}

resource "aws_security_group_rule" "ingress_cidr" {
  count = length(var.ingress_cidr)

  type              = "ingress"
  security_group_id = aws_security_group.av_ec2_sg[var.ingress_cidr[count.index]["inst"]].id

  from_port   = var.ingress_cidr[count.index]["port"]
  to_port     = var.ingress_cidr[count.index]["port"]
  protocol    = var.ingress_cidr[count.index]["protocol"]
  cidr_blocks = var.ingress_cidr[count.index]["cidr_blocks"]
}
resource "aws_security_group_rule" "ingress_sg" {
  count = length(var.ingress_sg)

  type              = "ingress"
  security_group_id = aws_security_group.av_ec2_sg[var.ingress_sg[count.index]["inst"]].id

  from_port                = var.ingress_sg[count.index]["port"]
  to_port                  = var.ingress_sg[count.index]["port"]
  protocol                 = var.ingress_sg[count.index]["protocol"]
  source_security_group_id = var.ingress_sg[count.index]["source_security_group_id"]
}
resource "aws_security_group_rule" "egress_cidr" {
  count = length(var.egress_cidr)

  type              = "egress"
  security_group_id = aws_security_group.av_ec2_sg[var.egress_cidr[count.index]["inst"]].id

  from_port   = var.egress_cidr[count.index]["port"]
  to_port     = var.egress_cidr[count.index]["port"]
  protocol    = var.egress_cidr[count.index]["protocol"]
  cidr_blocks = var.egress_cidr[count.index]["cidr_blocks"]
}
resource "aws_security_group_rule" "egress_sg" {
  count = length(var.egress_sg)

  type              = "egress"
  security_group_id = aws_security_group.av_ec2_sg[var.egress_sg[count.index]["inst"]].id

  from_port                = var.egress_sg[count.index]["port"]
  to_port                  = var.egress_sg[count.index]["port"]
  protocol                 = var.egress_sg[count.index]["protocol"]
  source_security_group_id = var.egress_sg[count.index]["source_security_group_id"]
}






/*resource "aws_security_group" "av_ec2_pub_sg" {
  name        = "av-t-ec2-pub-sg"
  description = "pub sg"
  # diff
  vpc_id = "${aws_vpc.av_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "av-t-ec2-pub-sg"
    project = "PE-Training"
    module  = "terraform"
  }
}
resource "aws_security_group" "av_ec2_pvt_sg" {
  name        = "av-t-ec2-pvt-sg"
  description = "pvt sg"
  # diff
  vpc_id = "${aws_vpc.av_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.av_pub_inst.private_ip}/32"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.av_pub_inst.private_ip}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "av-t-ec2-pvt-sg"
    project = "PE-Training"
    module  = "terraform"
  }
}*/
