output "alb_dns" {
  value = module.alb.lb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arns[0]
}