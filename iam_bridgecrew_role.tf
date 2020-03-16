resource aws_iam_role "bridgecrew_account_role" {
  name               = "${local.resource_name_prefix}-bridgecrewcwssarole"
  assume_role_policy = data.aws_iam_policy_document.bridgecrew_account_assume_role.json
}

data aws_iam_policy_document "bridgecrew_account_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.bridgecrew_account_id}:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [random_string.external_id.result]
    }
  }
}

resource aws_iam_role_policy_attachment "bridgecrew_security_audit" {
  role       = aws_iam_role.bridgecrew_account_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource aws_iam_role_policy_attachment "bridgecrew_cloud_formation" {
  role       = aws_iam_role.bridgecrew_account_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess"
}

resource "null_resource" "await_for_role_setup" {
  provisioner "local-exec" {
    command = "sleep 10"
  }

  depends_on = [aws_iam_role_policy_attachment.bridgecrew_security_audit, aws_iam_role_policy_attachment.bridgecrew_security_audit]
}