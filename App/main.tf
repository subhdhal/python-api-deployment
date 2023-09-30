# create VPC
module "VPC" {
    source                      = "../modules/VPC"
    vpc_cidr_block              = var.VCP_CIDER_BLOCK
    public_subnet_cidr_block    = var.PUB_SUBENT_CIDER_BLOCK
    destination_cidr_block      = var.DEST_CIRDER_BLCOK
}

module "IAM" {
    source                      = "../modules/IAM"
    name                        = var.IAM_NAME
}

module "ECS_CLUSTER" {
    source                      = "../modules/ECS"
    name                        = var.CLUSTER_NAME
}

module "ECS_SERVICES" {
    source                      = "../modules/ECS_Services"
    name                        = var.ECS_SERVICES_NAME
    cluster_id                  = module.ECS_CLUSTER.ecs_cluster_id
    public_subnet_id            = module.VPC.public_subnet_id
    ecs_sg_id                   = module.VPC.ecs_sg_id
    ecs_execution_task_role_arn = module.IAM.ecs_task_execution_role_arn
    AWS_ECR_DOCKER_IMAGE_URI    = var.ECR_IMAGE_URI
}
