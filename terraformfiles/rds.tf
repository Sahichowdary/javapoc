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

  provisioner "local-exec" {
     command = <<-EOT
      "mysql -h ${self.endpoint} -u ${var.rds.username} -p ${var.rds.password}"
      "const query = `INSERT INTO FoodFinder.users (first_name, last_name, username, email, password) VALUES(?, ?, ?, ?, ?)`;"
      "CREATE DATABASE foodfinder;"
      "use foodfinder;"
      "CREATE TABLE users ( first_name varchar(255), last_name varchar(255), username varchar(255), email varchar(255), password varchar(255) );"
      "insert into users values ( "raj", "kapoor", "rajKapoor", "raj.kapoor@gmail.com", "rajKapoor");"
    EOT
        }
}

