module "dev_cluster" {
  source        = "./cluster"
  cluster_name  = "dev"
  instance_type = "DEV1-XL"
  disk_size_gb  = "120"
  image_type    = "ubuntu_focal"
}

module "staging_cluster" {
  source        = "./cluster"
  cluster_name  = "staging"
  instance_type = "GP1-XS"
  disk_size_gb  = "150"
  image_type    = "ubuntu_focal"
}

module "production_cluster" {
  source        = "./cluster"
  cluster_name  = "production"
  instance_type = "GP1-M"
  disk_size_gb  = "550"
  image_type    = "ubuntu_focal"
}