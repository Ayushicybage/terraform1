resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.0.0"

  identifier = "app-db"

  engine = "mysql"
  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_user
  password = var.db_pass

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  subnet_ids             = var.subnet_ids

  skip_final_snapshot = true
}