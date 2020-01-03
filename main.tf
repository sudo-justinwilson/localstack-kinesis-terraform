module "localstack" {
  source = "./modules/localstack"
}

module "kinesis" {
  source = "./modules/kinesis"
}

module "docker" {
  source = "./modules/docker"
}