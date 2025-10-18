module "vpc" {
  source                = "./modules/vpc"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  public_subnet_1_az    = var.public_subnet_1_az
  public_subnet_2_az    = var.public_subnet_2_az
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  private_subnet_1_az   = var.private_subnet_1_az
  private_subnet_2_az   = var.private_subnet_2_az
}

module "Iam" {
  source     = "./modules/Iam"
  aws_region = var.aws_region
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
}

module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "alb" {
  source                 = "./modules/alb"
  project_name           = var.project_name
  vpc_id                 = module.vpc.vpc_id
  public_subnet_1_id     = module.vpc.public_subnet_1_id
  public_subnet_2_id     = module.vpc.public_subnet_2_id
  security_group_alb_ids = module.security_groups.security_group_alb_ids
  certificate_arn        = module.acm.certificate_arn
  containerPort          = var.containerPort
}

module "ecs_service" {
  source                                      = "./modules/ecs_service"
  project_name                                = var.project_name
  domain_name                                 = var.domain_name
  db_username                                 = var.db_username
  db_password                                 = var.db_password
  private_subnet_1_id                         = module.vpc.private_subnet_1_id
  private_subnet_2_id                         = module.vpc.private_subnet_2_id
  security_group_ecs_ids                      = module.security_groups.security_group_ecs_ids
  ecs_task_execution_role                     = module.Iam.ecs_task_execution_role
  target_group_arn                            = module.alb.target_group_arn
  ecr_image_url                               = var.ecr_image_url
  task_cpu                                    = var.task_cpu
  task_memory                                 = var.task_memory
  containerPort                               = var.containerPort
  ecs_task_deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  alb_https_listener_arn                      = module.alb.alb_https_listener_arn
  secret_key                                  = var.secret_key
  utils_secret                                = var.utils_secret
  rds_endpoint                                = module.rds.rds_endpoint
  redis_endpoint                              = module.elasticache.redis_endpoint
  db_url_ssm_arn                              = aws_ssm_parameter.db_url.arn
  redis_url_ssm_arn                           = aws_ssm_parameter.redis_url.arn
  redis_collab_url_ssm_arn                    = aws_ssm_parameter.redis_collab_url.arn
  secret_key_ssm_arn                          = aws_ssm_parameter.secret_key.arn
  utils_secret_ssm_arn                        = aws_ssm_parameter.utils_secret.arn
}

module "rds" {
  source              = "./modules/rds"
  project_name        = var.project_name
  db_username         = var.db_username
  db_password         = var.db_password
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
  rds_sg_id           = module.security_groups.rds_sg_id
}

module "elasticache" {
  source              = "./modules/elasticache"
  project_name        = var.project_name
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
  redis_sg_id         = module.security_groups.redis_sg_id
}
