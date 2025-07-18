terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-bucket-934746"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state_lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source                = "./modules/vpc"
  cluster_name          = var.cluster_name
  vpc_cidr              = var.vpc_cidr_block
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}

module "eks" {
  source         = "./modules/eks"
  cluster_name   = var.cluster_name
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = concat(
    module.vpc.public_subnet_ids,
    module.vpc.private_subnet_ids
  )
  node_groups   = var.node_groups
   environment = var.environment
  
}
resource "aws_route53_zone" "my_zone" {
  name    = "jayavardhanreddy616.xyz"
  comment = "demo e-commerce project"
}
resource "aws_route53_record" "frontend" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name    = "jayavardhanreddy616.xyz"
  type    = "A"
  alias {
    name                   = "dualstack.k8s-default-frontend-6e54782b3e-1405919575.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
    evaluate_target_health = true
  }
}
module "acm" {
  source  = "./modules/acm"

  domain_name = "*.jayavardhanreddy616.xyz"
  zone_id     = aws_route53_zone.my_zone.zone_id

  

  tags = {
    Project = "ACM-Wildcard"
  }
}


resource "aws_sns_topic" "alarm_topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email
}

module "cloudwatch_alarm" {
  for_each      = toset(var.instance_ids)
  source        = "./modules/cloudwatch"
  alarm_name = "${var.alarm_name}-${each.key}"
  threshold     = var.threshold
  instance_id   = each.value

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}

module "cloudwatch_dashboard" {
  source          = "./modules/cloudwatch"
  dashboard_name  = "${var.cluster_name}-dashboard"
  region          = "us-east-1"
  cluster_name    = var.cluster_name
  nodegroup_name  = "eks_nodes"
}



