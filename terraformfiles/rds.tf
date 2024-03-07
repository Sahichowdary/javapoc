resource "aws_db_subnet_group" "rds_subnetgroup" {
  name      = "rds-subnet-main"
  subnet_ids = [aws_subnet.vpc_private_subnet_private_6.id, aws_subnet.vpc_private_subnet_private_5.id, aws_subnet.vpc_private_subnet_private_3.id, aws_subnet.vpc_private_subnet_private_4.id]
}

resource "aws_db_instance" "my-pocsql" {
  allocated_storage    = var.rds.storage
  db_name              = "mysqlpoc_sasken"
  identifier           = var.rds.name
  engine               = "mysql"
  engine_version       = var.rds.engine_version
  db_subnet_group_name  = aws_db_subnet_group.rds_subnetgroup.id
  instance_class       = "db.t3.micro"
  username             = var.rds.username
  password             = var.rds.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible = var.rds.public_access
  storage_type = "standard"
  vpc_security_group_ids = [aws_security_group.eks_cluster_sg.id]
  depends_on = [aws_db_subnet_group.rds_subnetgroup] 

 # provisioner "local-exec" {
 #    command = "mysql -h ${self.endpoint} -u ${var.rds.username} -p${var.rds.password} < path_to_your_sql_script.sql"
 # }
}

