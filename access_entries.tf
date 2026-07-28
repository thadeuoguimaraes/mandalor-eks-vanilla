resource "aws_eks_access_entry" "fargate" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_iam_role.fargate.arn
  type          = "FARGATE_LINUX"
}