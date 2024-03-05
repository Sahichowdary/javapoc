variable "region" {
    description = "used to specify the region"
    default = "us-east-1"
}

variable "availability_zone" {
    default = "us-east-1a"
}

variable "availability_zone2" {
    default = "us-east-1b"
}

variable "eks_cluster_role" {
    default = "arn:aws:iam::036965198866:role/aws_eks_demo_test"
}

variable "eks_node_role" {
    default = "arn:aws:iam::036965198866:role/EKS-Node-Group-role"
}

variable "eks_encryption_key" {
    default = "arn:aws:kms:us-east-1:036965198866:key/48e8799d-ee0c-4462-a8da-28ae9073ab40"
}

variable "loadbalancer_id" {
    default = " "
    
}

variable "rds" {
  type = object({
    name = string
    storage = number
    engine_version = string
    username = string
    password = string
    public_access = bool
  })
}
