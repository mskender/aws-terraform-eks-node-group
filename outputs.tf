output arn {
    description = "Worker gorup ARN"
    value = var.create_node_group ?  aws_eks_node_group.workers[0].arn : null
}

output role_arn {
    description = "Worker gorup IAM role ARN"
    value = var.create_node_group ?  aws_iam_role.eks-worker[0].arn : null
}