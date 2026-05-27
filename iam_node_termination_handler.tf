# IAM Role para o AWS Node Termination Handler (IRSA)
# Gerenciado fora do módulo pois usa SQS Queue configurada neste projeto

data "aws_iam_policy_document" "nth_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      type        = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${module.eks.oidc_provider_url}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node-termination-handler"]
    }
  }
}

resource "aws_iam_role" "node_termination_handler" {
  name               = "${var.cluster_name}-node-termination-handler"
  assume_role_policy = data.aws_iam_policy_document.nth_assume.json
  tags               = var.tags
}

data "aws_iam_policy_document" "nth_policy" {
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:CompleteLifecycleAction",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeTags",
      "ec2:DescribeInstances",
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "node_termination_handler" {
  name   = "${var.cluster_name}-node-termination-handler"
  policy = data.aws_iam_policy_document.nth_policy.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "node_termination_handler" {
  role       = aws_iam_role.node_termination_handler.name
  policy_arn = aws_iam_policy.node_termination_handler.arn
}
