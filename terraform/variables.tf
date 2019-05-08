
variable "tilloo_cidr_block" {
    default = "10.2.0.0/16"
}

variable "tilloo_cidr_prefix" {
    default = "10.2"
}

variable "cluster_name" {
    default = "tilloo"
}

variable "worker_instance_type" {
    default= "t3.small"
}

variable "worker_desired_capacity" {
    default = "3"
}

variable "worker_min_size" {
    default = "2"
}

variable "worker_max_size" {
    default = "4"
}
