resource "aws_security_group" "app_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.0.0"

  name = "${var.env}-asg"

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier = var.subnets

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  security_groups = [aws_security_group.app_sg.id]

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y nginx mysql

echo "DB=${var.db_endpoint}" > /usr/share/nginx/html/index.html
systemctl start nginx
EOF
)

  target_group_arns = [var.target_arn]
}