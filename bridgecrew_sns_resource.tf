data template_file "message" {
  template = file("${path.module}/message.json")
  vars = {
    request_type         = "Create"
    bridgecrew_sns_topic = local.bridgecrew_sns_topic
    customer_name        = var.org_name
    account_id           = data.aws_caller_identity.caller.account_id
    external_id          = random_uuid.external_id.result
    role_arn             = aws_iam_role.bridgecrew_account_role.arn
    region               = data.aws_region.region.id
  }
}

resource null_resource "create_bridgecrew" {
  provisioner "local-exec" {
    command     = "aws sns ${local.profile_str} --region ${data.aws_region.region.id} publish --target-arn \"${local.bridgecrew_sns_topic}\" --message '${jsonencode(data.template_file.message.rendered)}' && sleep 30"
    working_dir = path.module
  }

  depends_on = [null_resource.await_for_role_setup]
}

resource null_resource "update_bridgecrew" {
  triggers = {
    build = md5(data.template_file.message.rendered)
  }

  provisioner "local-exec" {
    command     = "aws sns ${local.profile_str} --region ${data.aws_region.region.id} publish --target-arn \"${local.bridgecrew_sns_topic}\" --message '${jsonencode(replace(data.template_file.message.rendered, "Create", "Update"))}'"
    working_dir = path.module
  }

  depends_on = [null_resource.create_bridgecrew]
}

resource null_resource "disconnect_bridgecrew" {
  triggers = {
    profile   = local.profile_str
    region    = data.aws_region.region.id
    message   = jsonencode(replace(data.template_file.message.rendered, "Create", "Delete"))
    sns_topic = local.bridgecrew_sns_topic
  }

  provisioner "local-exec" {
    command     = "aws sns ${self.triggers.profile} --region ${self.triggers.region} publish --target-arn \"${self.triggers.sns_topic}\" --message '${self.triggers.message}'"
    when        = destroy
    working_dir = path.module
  }

  depends_on = [null_resource.create_bridgecrew]
}