resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.0.0"

  name = "${var.env}-alb"

  vpc_id  = var.vpc_id
  subnets = var.subnets

  security_groups = [aws_security_group.alb_sg.id]

  target_groups = [
    {
      name_prefix = "app"
      backend_protocol = "HTTP"
      backend_port = 80
      target_type = "instance"
    }
  ]

  listeners = [
    {
      port = 80
      protocol = "HTTP"
      default_action = {
        type = "forward"
        target_group_index = 0
      }
    }
  ]
}