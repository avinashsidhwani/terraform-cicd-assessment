output "vpc_id" {
  value = "${aws_vpc.av_vpc.id}"
}
output "subnet_ids" {
  value = "${aws_subnet.av_subnet[*].id}"
}

output "subnets" {
  value = var.subnets
}
# output "subnet_ids" {
#   value = aws_subnet.av_subnet[*].ids
# }
output "subnet_db_grp" {
  value = var.subnet_db_grp
}
