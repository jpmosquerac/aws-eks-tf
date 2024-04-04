variable "eks_cluster_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID from which belongs the subnets"
}

variable "eks_cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "node_group_name" {
  type        = string
  description = "Name of the Node Group"
}

variable "endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

variable "ami_type" {
  type        = string
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
}

variable "disk_size" {
  type        = number
  description = "Disk size in GiB for worker nodes. Defaults to 20."

}

variable "instance_types" {
  type        = list(string)
  description = "Set of instance types associated with the EKS Node Group."
}

variable "pvt_desired_size" {
  type        = number
  description = "Desired number of worker nodes in private subnet"
}

variable "pvt_max_size" {
  type        = number
  description = "Maximum number of worker nodes in private subnet."
}

variable "pvt_min_size" {
  type        = number
  description = "Minimum number of worker nodes in private subnet."
}

variable "pblc_desired_size" {
  type        = number
  description = "Desired number of worker nodes in public subnet"
}

variable "pblc_max_size" {
  type        = number
  description = "Maximum number of worker nodes in public subnet."

}

variable "pblc_min_size" {
  type        = number
  description = "Minimum number of worker nodes in public subnet."
}

variable "cluster_sg_name" {
  type        = string
  description = "Name of the EKS cluster Security Group"
}

variable "nodes_sg_name" {
  type        = string
  description = "Name of the EKS node group Security Group"
}