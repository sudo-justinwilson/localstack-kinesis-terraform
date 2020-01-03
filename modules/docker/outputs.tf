output "random_container" {
  description = "The exit code of docker run command"
  value       = docker_container.random.container_logs
}

output "random_container_ip_addr" {
  value = docker_container.random.network_data
}