# ======= VPC =======
resource "aws_vpc" "av_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = merge(var.common_tags, var.vpc_tags)
}


# ======= subnets =======
resource "aws_subnet" "av_subnet" {
  count = 3

  vpc_id            = "${aws_vpc.av_vpc.id}"
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = "${var.region}${var.subnet_azs[count.index]}"

  tags = merge(var.common_tags, var.subnet_tags[count.index])
}
