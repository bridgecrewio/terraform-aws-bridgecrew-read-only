locals {
  request_type         = "Create"
  bridgecrew_sns_topic = "arn:aws:sns:${data.aws_region.region.name}:${var.bridgecrew_account_id}:${var.topic_name}"
  customer_name        = var.org_name
  account_id           = data.aws_caller_identity.caller.account_id
  external_id          = random_uuid.external_id.result
  role_arn             = aws_iam_role.bridgecrew_account_role.arn
  region               = data.aws_region.region.id
  api_token            = var.api_token

  message_template     = templatefile("${path.module}/message.json.tpl",
    {
      request_type = local.request_type,
      bridgecrew_sns_topic = local.bridgecrew_sns_topic,
      customer_name = local.customer_name,
      account_id = local.account_id,
      external_id = local.external_id,
      role_arn = local.role_arn,
      region = local.region,
      api_token = local.api_token,
    })
}

resource "null_resource" "create_bridgecrew" {
  triggers = {
    build = md5(local.message_template)
  }

  provisioner "local-exec" {
    command     = "aws sns ${local.profile_str} --region ${data.aws_region.region.id} publish --target-arn \"${local.bridgecrew_sns_topic}\" --message '${jsonencode(local.message_template)}' && sleep 30"
    working_dir = path.module
  }

  depends_on = [null_resource.await_for_role_setup]
}

resource "null_resource" "update_bridgecrew" {
  triggers = {
    build = md5(local.message_template)
  }

  provisioner "local-exec" {
    command     = "aws sns ${local.profile_str} --region ${data.aws_region.region.id} publish --target-arn \"${local.bridgecrew_sns_topic}\" --message '${jsonencode(replace(local.message_template, "Create", "Update"))}'"
    working_dir = path.module
  }

  depends_on = [null_resource.create_bridgecrew]
}

resource "null_resource" "disconnect_bridgecrew" {
  triggers = {
    profile   = local.profile_str
    region    = data.aws_region.region.id
    message   = jsonencode(replace(local.message_template, "Create", "Delete"))
    sns_topic = local.bridgecrew_sns_topic
  }

  provisioner "local-exec" {
    command     = "aws sns ${self.triggers.profile} --region ${self.triggers.region} publish --target-arn \"${self.triggers.sns_topic}\" --message '${self.triggers.message}'"
    when        = destroy
    working_dir = path.module
  }

  depends_on = [null_resource.create_bridgecrew]
}
