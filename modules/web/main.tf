resource "aws_security_group" "alb_sg" {
  name   = "${var.env}-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  name = "${var.env}-alb"

  load_balancer_type = "application"

  vpc_id  = var.vpc_id
  subnets = var.subnets

  security_groups = [aws_security_group.alb_sg.id]

  target_groups = [
    {
      name_prefix      = "app"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}