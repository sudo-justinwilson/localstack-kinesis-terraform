# Configure the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Start a container
resource "docker_container" "localstack" {
  name  = "terraform_localstack"
  image = "localstack/localstack:latest"
  ports {
    internal = 8080
    external = 8080
  }
  ports {
    internal = 4563
    external = 4563
  }
  ports {
    internal = 4564
    external = 4564
  }
  ports {
    internal = 4565
    external = 4565
  }
  ports {
    internal = 4566
    external = 4566
  }
  ports {
    internal = 4567
    external = 4567
  }
  ports {
    internal = 4568
    external = 4568
  }
  ports {
    internal = 4569
    external = 4569
  }
  ports {
    internal = 4570
    external = 4570
  }
  ports {
    internal = 4571
    external = 4571
  }
  ports {
    internal = 4572
    external = 4572
  }
  ports {
    internal = 4573
    external = 4573
  }
  ports {
    internal = 4574
    external = 4574
  }
  ports {
    internal = 4575
    external = 4575
  }
  ports {
    internal = 4576
    external = 4576
  }
  ports {
    internal = 4577
    external = 4577
  }
  ports {
    internal = 4578
    external = 4578
  }
  ports {
    internal = 4579
    external = 4579
  }
  ports {
    internal = 4580
    external = 4580
  }
  ports {
    internal = 4581
    external = 4581
  }
  ports {
    internal = 4582
    external = 4582
  }
  ports {
    internal = 4583
    external = 4583
  }
  ports {
    internal = 4584
    external = 4584
  }
  ports {
    internal = 4585
    external = 4585
  }
  ports {
    internal = 4586
    external = 4586
  }
  ports {
    internal = 4587
    external = 4587
  }
  ports {
    internal = 4588
    external = 4588
  }
  ports {
    internal = 4589
    external = 4589
  }
  ports {
    internal = 4590
    external = 4590
  }
  ports {
    internal = 4591
    external = 4591
  }
  ports {
    internal = 4592
    external = 4592
  }
  ports {
    internal = 4593
    external = 4593
  }
  ports {
    internal = 4594
    external = 4594
  }
  ports {
    internal = 4595
    external = 4595
  }
  ports {
    internal = 4596
    external = 4596
  }
  ports {
    internal = 4597
    external = 4597
  }
  ports {
    internal = 4598
    external = 4598
  }
  ports {
    internal = 4599
    external = 4599
  }
  #volumes {
  #  volume_name = "tmp_localstack"
  #  #host_path = "/home/justinwilson/workspaces/git/bigtincan/docker_provider/.localstack"
  #  #host_path = "./.localstack"
  #  host_path = "/tmp/.localstack"
  #  container_path = "/tmp/localstack"
  #}
  volumes {
    volume_name = "docker_socket"
    host_path = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
  #env = ["DEBUG=1", "DATA_DIR=/tmp/localstack/data"]
  # Setting AWS_CBOR_DISABLE=1 is meant to fix the "Caught exception while sync'ing Kinesis shards and leases" localstack Kinesis error:
  env = ["DEBUG=1", "DATA_DIR=/tmp/localstack/data", "AWS_CBOR_DISABLE=1"]
}

# Find the latest Localstack image.
resource "docker_image" "localstack" {
  name = "localstack/localstack:latest"
}
