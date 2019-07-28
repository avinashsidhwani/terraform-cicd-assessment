module "network" {
  source = "./modules/network"

  region      = var.region
  common_tags = var.common_tags

  # ======= vpc and subnets =======
  vpc_tags = {
    Name = "av-t-vpc"
  }
  vpc_cidr = "10.2.0.0/16"
  /*subnet = [
    {
      #index = 0
      #custom_tags = {
      #  Name = "1"
      #}
      #cidr = "10.2.1.0/24"
      # public = true
      az     = "a"
      db_grp = false
    },
    {
      index = 1
      custom_tags = {
        Name = "2"
      }
      cidr = "10.2.2.0/24"
      # public = false
      az     = "a"
      db_grp = true
    },
    {
      index = 2
      custom_tags = {
        Name = "3"
      }
      cidr = "10.2.3.0/24"
      # public = false
      az     = "b"
      db_grp = true
    }
  ]*/
  subnets       = [0, 1, 2]
  subnet_tags   = [{ Name = "1" }, { Name = "2" }, { Name = "3" }]
  subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
  subnet_azs    = ["a", "a", "b"]
  subnet_db_grp = [false, true, true]



  # ======= gateways =======
  igw_tags = {
    Name = "av-t-igw"
  }
  /*natgw = {
    allocation_id = "eipalloc-0056c0a84cafca0ed"
    custom_tags = {
      Name = "av-t-natgw"
    }
  }*/
  natgw_alloc_id = "eipalloc-0056c0a84cafca0ed"
  natgw_tags = {
    Name = "av-t-natgw"
  }

}



module "ec2" {
  source = "./modules/ec2-inst"

  common_tags = var.common_tags
  vpc_id      = module.network.vpc_id
  subnet_ids  = module.network.subnet_ids

  rds_endpoint = module.rds.rds_endpoint
  rds_usr      = var.db_usr
  rds_pwd      = var.db_pwd
  rds_dbname   = var.db_name

  # ======= ec2 security groups =======
  ec2_sg = [
    {
      name = "av-t-ec2-pub-sg"
      desc = "pub sg"
    },
    {
      name = "av-t-ec2-pvt-sg"
      desc = "pvt sg"
    }
  ]
  ec2_sg_tags = [{ Name = "av-t-ec2-pub-sg" }, { Name = "av-t-ec2-pvt-sg" }]

  ingress_cidr = [
    {
      inst        = 0
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  ingress_sg = [
    {
      inst                     = 1
      port                     = 22
      protocol                 = "tcp"
      source_security_group_id = module.ec2.sg0_id
    }
  ]
  egress_cidr = [
    {
      inst        = 0
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      inst        = 0
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      inst        = 1
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      inst        = 1
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_sg = [
    {
      inst                     = 0
      port                     = 22
      protocol                 = "tcp"
      source_security_group_id = "${module.ec2.ec2_sg_1}"
    },
    {
      inst                     = 1
      port                     = 3306
      protocol                 = "tcp"
      source_security_group_id = "${module.rds.rds_sg_id}"
    }
  ]

  # ======= ec2 instances =======
  # ec2_inst = [
  #   {
  #     ami                         = "ami-026c8acd92718196b"
  #     instance_type               = "t2.micro"
  #     associate_public_ip_address = true
  #     custom_tags = {
  #       Name = "av-t-pub-inst"
  #     }
  #     subnet_no = 0
  #     sg_no     = 0
  #     key_name  = "" # kept empty on purpose

  #     has_userdata = false
  #   },
  #   {
  #     ami                         = "ami-035b3c7efe6d061d5"
  #     instance_type               = "t2.micro"
  #     associate_public_ip_address = false
  #     custom_tags = {
  #       Name = "av-t-pvt-inst"
  #     }
  #     subnet_no = 1
  #     sg_no     = 1
  #     key_name  = "" # kept empty on purpose

  #     has_userdata  = true
  #     userdata_file = "user_data.sh"
  #   }
  # ]
  ec2_inst_amis          = ["ami-026c8acd92718196b", "ami-035b3c7efe6d061d5"]
  ec2_inst_types         = ["t2.micro", "t2.micro"]
  ec2_inst_pub_ip        = [true, false]
  ec2_inst_tags          = [{ Name = "av-t-pub-inst" }, { Name = "av-t-pvt-inst" }]
  ec2_inst_subnet_nos    = [0, 1]
  ec2_inst_sg_nos        = [0, 1]
  ec2_inst_keynames      = ["", ""] # kept empty on purpose
  ec2_inst_has_userdata  = [false, true]
  ec2_inst_userdata_file = ["nodata.tpl", "user_data.tpl"]

}



module "rds" {
  source = "./modules/rds-inst"

  common_tags   = var.common_tags
  vpc_id        = module.network.vpc_id
  db_subnet_ids = [for index in module.network.subnets : module.network.subnet_ids[index] if module.network.subnet_db_grp[index]]

  # ======= rds security groups =======
  rds_sg = {
    name = "av-t-rds-sg"
    desc = "allow access to pvt ec2 instance"
    # custom_tags = {
    #   Name = "av-t-rds-sg"
    # }
  }
  rds_sg_tags = { Name = "av-t-rds-sg" }
  rds_ingress_sg = [
    {
      port                     = 3306
      protocol                 = "tcp"
      source_security_group_id = module.ec2.ec2_sg_1
    }
  ]

  # ======= rds db subnet group =======
  # db_subnet_grp = {
  #   name = "av-t-rds-sub-grp"
  #   custom_tags = {
  #     Name = "av-t-rds-sub-grp"
  #   }
  # }
  db_subnet_grp_name = "av-t-rds-sub-grp"
  db_subnet_grp_tags = { Name = "av-t-rds-sub-grp" }

  # ======= rds instance =======
  rds_inst = {
    # allocated_storage      = 20
    engine         = "mysql"
    engine_version = "5.7.22"
    instance_class = "db.t2.micro"
    name           = var.db_name
    username       = var.db_usr
    password       = var.db_pwd
    db_subnet_grp  = module.rds.subnet_grp_id
    # vpc_security_group_ids = ["${aws_security_group.av_rds_sg.id}"]
    skip_final_snapshot = "true"
  }
  rds_inst_alloc_storage = 20
  # rds_inst_security_group_ids = module.rds.rds_sg_id
}
