# ======= ec2 instances =======
resource "aws_instance" "av_ec2_inst" {
  count = length(var.ec2_inst_amis)

  ami                         = var.ec2_inst_amis[count.index]
  instance_type               = var.ec2_inst_types[count.index]
  associate_public_ip_address = var.ec2_inst_pub_ip[count.index]

  tags = merge(var.common_tags, var.ec2_inst_tags[count.index])

  subnet_id              = var.subnet_ids[var.ec2_inst_subnet_nos[count.index]]
  vpc_security_group_ids = ["${aws_security_group.av_ec2_sg[var.ec2_inst_sg_nos[count.index]].id}"]
  key_name               = var.ec2_inst_keynames[count.index]

  user_data = var.ec2_inst_has_userdata[count.index] ? "${data.template_file.userdata[count.index].rendered}" : ""
}




/*resource "aws_instance" "av_pub_inst" {
  ami = ""
  instance_type = 
  associate_public_ip_address = true
  tags = {
    Name = ""
    email = "avinash.sidhwani@quantiphi.com"
    project = "PE-Training"
    module = "terraform"
  }
  # diff
  subnet_id = "${aws_subnet.av_pub_subnet1.id}"
  vpc_security_group_ids = ["${aws_security_group.av_ec2_pub_sg.id}"]
  
  key_name = "av-training-all"
}

resource "aws_instance" "av_pvt_inst" {
  #ami = "ami-026c8acd92718196b"
  ami = ""
  instance_type = 
  tags = {
    Name = "av-t-pvt-inst"
    email = "avinash.sidhwani@quantiphi.com"
    project = "PE-Training"
    module = "terraform"
  }
  # diff
  subnet_id = "${aws_subnet.av_pvt_subnet1.id}"
  vpc_security_group_ids = ["${aws_security_group.av_ec2_pvt_sg.id}"]
  
  key_name = "av-training-all"
  
  # user_data = "${file("user_data.sh")}"
  
  user_data = <<EOF
    #!/bin/bash
    yum update -y
    echo "starting installation" >> start-up.log
    yum install mysql-server -y
    echo "installed" >> start-up.log
    /sbin/service mysqld start
    mysqladmin -u root password 'toor'
    RDS_MYSQL_ENDPOINT="${element(split(":", aws_db_instance.av_rds.endpoint), 0)}";
    RDS_MYSQL_USER="av_t_rds_usr";
    RDS_MYSQL_PASS="av_t_rds_pwd";
    RDS_MYSQL_BASE="av_t_rds";
    mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE -e 'quit';
    if [[ $? -eq 0 ]]; then
      echo "MySQL connection: OK" >> conn;
      mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE --execute='CREATE TABLE shriram( id INT)';
      echo "MySQL table create" >> conn;
      mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE --execute='INSERT into shriram (id) VALUES (1)';
      echo "MySQL insert" >> conn;
      mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE --execute='SELECT * from shriram' >> conn;
      echo "MySQL select" >> conn;
    else
      echo "MySQL connection: Fail" >> conn;
    fi;
    EOF
  
  /*provisioner "remote-exec" {
    # inline = []
    script = "mysql_script.sh"
  }*
}*/
