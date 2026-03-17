module "network" {
  source = "./modules/network"

  env = var.env
}

module "web" {
  source = "./modules/web"

  vpc_id  = module.network.vpc_id
  subnets = module.network.public_subnets
  env     = var.env
}

module "db" {
  source = "./modules/db"

  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnets

  db_name = var.db_name
  db_user = var.db_user
  db_pass = var.db_pass
}

module "app" {
  source = "./modules/app"

  vpc_id     = module.network.vpc_id
  subnets    = module.network.private_subnets
  target_arn = module.web.target_group_arn

  db_endpoint = module.db.db_endpoint

  instance_type   = var.instance_type
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  ami_id = var.ami_id
  env    = var.env
}