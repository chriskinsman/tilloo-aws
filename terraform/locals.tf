locals {
    k8s_version = "1.14"
    tilloo_cidr_prefix = "10.2"
    tilloo_cidr_block = "${local.tilloo_cidr_prefix}.0.0/16"
    cluster_name = "tilloo"
    worker_instance_type = "t3.small"
    worker_desired_capacity = "3"
    worker_min_size = "2"
    worker_max_size = "4"
}