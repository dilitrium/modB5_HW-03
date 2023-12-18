output "internal_ip_address_vm_1" {
  value = module.ya_instance_1.internal_ip_address_vm
}

output "external_ip_address_vm_1" {
  value = module.ya_instance_1.external_ip_address_vm
}

output "internal_ip_address_vm_2" {
  value = module.ya_instance_2.internal_ip_address_vm
}

output "external_ip_address_vm_2" {
  value = module.ya_instance_2.external_ip_address_vm
}

output "NLB_ip_address" {
  value = yandex_lb_network_load_balancer.sf_lb.listener[*].external_address_spec
}