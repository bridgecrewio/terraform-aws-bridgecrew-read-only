# Bridgecrew AWS ReadOnly Integration

[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridgecrew.io)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/bridgecrewio/terraform-aws-bridgecrew-read-only.svg?label=latest)](https://github.com/bridgecrewio/terraform-aws-bridgecrew-read-only/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/bridgecrewio/terraform-aws-bridgecrew-read-only/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=bridgecrewio%2Fterraform-aws-bridgecrew-read-only&benchmark=CIS+AWS+V1.2)

## Installation Options

This is a Terraform module that creates an Amazon Web Services (AWS) Read Only integration with Bridgecrew.

### Starting fresh

This stack creates a role with a dedicated External ID which allows only authorized access from Bridgecrew's AWS account

## Usage

Include **module.readonly.tf** in your existing Terraform code, and/or see *example/examplea* as your guide:

```terraform
module "readonly" {
  source      = "bridgecrewio/bridgecrew-read-only/aws"
  version     = "v1.5.4"
  org_name    = "<your org name>"
  aws_profile = "<aws profile>"
  api-token   = var.api_token
}
```

The module requires that you set your Bridgecrew organisation name and the name of the AWS profile of the AWS account you want to attach Bridgecrew too.

The module expect the Bridgecrew platform API token to be supplied.

On Windows:

```powershell
$env:TF_VAR_api_token="your-platform-token"
```

On *nix:

```shell
export TF_VAR_api_token="your-platform-token"
```

Or you can leave it blank to be prompted at your console.

### Where do I get my Bridgecrew API token

![get my API token](https://files.readme.io/ae875bb-bc_api_key.gif)

## SSM example

In the examples folder you'll also find an example that drives this module but obtains the api_token
 from your AWS SSM parameter store. You'll have to add the variable there once yourself, but any future uses will obtain it without intervention.

```cli
aws ssm put-parameter --name /bridgecrew/api_token --value <your_token> --type SecureString
```

## Secrets manager example

Also in the examples folder you'll find an example that drives this module but obtains the api_token,
but this time from AWS secretsmanager.

```cli
aws secretsmanager create-secret --name /bridgecrew/api_token
aws secretsmanager put-secret-value --secret-id /bridgecrew/api_token --secret-string <your_token>
```

## Where

This module is supported for deployment in the following AWS regions:

- All US regions
- eu-west-1
- eu-central-1
- ap-northeast-1

However, its functionality will work across all AWS regions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.26.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.bridgecrew_account_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.bridgecrew_describe_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.bridgecrew_cloud_formation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.bridgecrew_security_audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [null_resource.await_for_role_setup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.create_bridgecrew](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.disconnect_bridgecrew](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.update_bridgecrew](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_uuid.external_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [aws_caller_identity.caller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bridgecrew_account_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.bridgecrew_describe_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_alias"></a> [account\_alias](#input\_account\_alias) | The alias of the account the CF is deployed in. This will be prepended to all the resources in the stack. Default is {org\_name}-bc | `string` | `""` | no |
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | This is your Bridgecrew platform Api token Set as and Environment variable TF\_VAR\_api\_token | `string` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The profile that was used to deploy this module. If the default profile / default credentials are used, seet this value to null. | `string` | n/a | yes |
| <a name="input_bridgecrew_account_id"></a> [bridgecrew\_account\_id](#input\_bridgecrew\_account\_id) | The Bridgecrew AWS account ID from which scans will originate. This value should not typically be modified, but is provided here to support testing and troubleshooting, if needed. | `string` | `"890234264427"` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Implements the common tags scheme | `map(any)` | <pre>{<br>  "integration": "bridgecrew-aws-readonly",<br>  "module": "terraform-aws-bridgecrew-read-only"<br>}</pre> | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | The name of the company the integration is for. Must be alphanumeric. | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name for the Bridgecrew read-only IAM role. | `string` | `""` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the SNS topic for Bridgecrew to receive notifications. This value should not typically be modified, but is provided here to support testing and troubleshooting, if needed. | `string` | `"handle-customer-actions"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_name"></a> [customer\_name](#output\_customer\_name) | The customer name as defined on Bridgecrew signup |
| <a name="output_message"></a> [message](#output\_message) | n/a |
| <a name="output_role"></a> [role](#output\_role) | The cross-account access role for Bridgecrew |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The cross-account access role ARN for Bridgecrew |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
| <a name="output_topic"></a> [topic](#output\_topic) | The SNS endpoint that enabled the account |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Related Projects

Check out these related projects.

- [terraform-aws-bridgecrew-remediation](https://github.com/bridgecrewio/terraform-aws-bridgecrew-remediation)

## Help

**Got a question?**

File a GitHub [issue](https://github.com/bridgecrewio/terraform-aws-bridgecrew-read-only/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/bridgecrewio/terraform-aws-bridgecrew-read-only/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2020-2021 Bridgecrew

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.
