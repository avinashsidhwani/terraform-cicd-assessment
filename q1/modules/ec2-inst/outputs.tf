output "sg0_id" {
  value = "${aws_security_group.av_ec2_sg[0].id}"
}
output "ec2_sg_1" {
  value = "${aws_security_group.av_ec2_sg[1].id}"
}
