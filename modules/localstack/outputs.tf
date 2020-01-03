output "container_ip_addr" {
  value = docker_container.localstack.network_data
}

output "localstack_container" {
  description = "The exit code of docker run command"
  value       = docker_container.localstack.exit_code
}
