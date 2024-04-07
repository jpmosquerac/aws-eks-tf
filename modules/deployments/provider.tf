provider "kubernetes" {
  host                   = var.aws_eks_cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
  cluster_ca_certificate = base64decode(var.aws_eks_cluster.certificate_authority.0.data)
}