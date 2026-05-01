module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "lesson-7-terraform-state-123456-unique"
  table_name  = "terraform-locks"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_name           = "lesson-7-vpc"
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-7-ecr"
  scan_on_push = true
}



module "eks" {
  source        = "./modules/eks"
  cluster_name  = "lesson-7-eks-cluster"     # Назва кластера
  subnet_ids    = module.vpc.private_subnets # ID підмереж
  instance_type = "t3.small"                 # Тип інстансів
  desired_size  = 2                          # Бажана кількість нодів
  max_size      = 6                          # Максимальна кількість нодів
  min_size      = 2                          # Мінімальна кількість нодів
}
