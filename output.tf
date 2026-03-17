output "alb_dns" {
  value = module.web.alb_dns
}

output "db_endpoint" {
  value = module.db.db_endpoint
}