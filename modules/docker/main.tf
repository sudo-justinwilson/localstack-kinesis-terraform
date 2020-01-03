# Configure the Docker provider to use the docker daemon on the localhost:
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Start a container
resource "docker_container" "random" {
  name  = "random_generator"
  image = "centos:latest"
  mounts {
    source = "${var.path}/aws"
    target = "/root/.aws"
    type = "bind"
  }
  mounts {
    source = "${var.path}/files"
    target = "/files"
    type = "bind"
  }

  entrypoint = ["/files/entrypoint.sh"]
  start = true
}