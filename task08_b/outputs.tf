output "redis_fqdn" {
  value = module.aci_redis.redis_fqdn
}

output "aca_fqdn" {
  value = module.aca.aca_fqdn
}

output "aks_lb_ip" {
  value = module.k8s.lb_ip
}