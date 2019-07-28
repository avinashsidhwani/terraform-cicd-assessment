# ======= route table and routes =======
resource "aws_route_table" "av_rt" {
  count = 2

  vpc_id = "${aws_vpc.av_vpc.id}"
}

resource "aws_route" "av_r1" {
  route_table_id         = "${aws_route_table.av_rt[0].id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.av_gateway.id}"
}
resource "aws_route" "av_r2" {
  route_table_id         = "${aws_route_table.av_rt[1].id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.av_nat_gw.id}"
}



# ======= associating route table with subnets =======
resource "aws_route_table_association" "av_rt_pub_subnet1" {
  count = 2

  subnet_id      = "${aws_subnet.av_subnet[count.index].id}"
  route_table_id = "${aws_route_table.av_rt[count.index].id}"
}
