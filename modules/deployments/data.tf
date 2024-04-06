data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.aws_eks_cluster.id
}