# ======= gateway =======
resource "aws_internet_gateway" "av_gateway" {
  vpc_id = "${aws_vpc.av_vpc.id}"

  tags = merge(var.common_tags, var.igw_tags)
}

# ======= nat gateway =======
resource "aws_nat_gateway" "av_nat_gw" {
  allocation_id = var.natgw_alloc_id
  subnet_id     = "${aws_subnet.av_subnet[0].id}"

  tags = merge(var.common_tags, var.natgw_tags)
}
