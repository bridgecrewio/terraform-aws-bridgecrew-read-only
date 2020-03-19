# Terraform Bridgecrew ReadOnly Integration
[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridgecrew.io)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/bridgecrewio/terraform-aws-bridgecrew-read-only.svg?label=latest)](https://github.com/bridgecrewio/terraform-aws-bridgecrew-read-only/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)
[![CircleCI](https://circleci.com/gh/bridgecrewio/terraform-aws-bridgecrew-read-only.svg?style=svg)](https://circleci.com/gh/bridgecrewio/terraform-aws-bridgecrew-cloudtrail)

## Installation Options
This is a terraform module that creates an Amazon Web Services (AWS) Read Only integration with Bridgecrew.

### Starting fresh
This stack creates a role with a dedicated External ID which allows only authorized access from Bridgecrew's AWS account

## Variables:
| Name | Required? | Type | Default Value | Example Value | Description |
|---|---|---|---|---|---|
| company_name| YES | String | | testcustomer | The name of the customer. Must be alphanumeric. |
| aws_profile | YES | String |  | prod | The name of the profile to be used. If using default AWS credentials, set this to null |
| account_alias | NO | String |  | prod | The alias of the account the CF is deployed in. This will be prepended to all the resources in the stack. Default is {company_name}-bc |

## Outuput
| Name |  Example Value | Description |
|------|----------------|-------------|
| role_arn | arn:aws:iam:us-east-1:012345678901:role/acme-bc-bridgecrewcws | The ARN of the role that was created |
| customer_name | acme | The name of the customer this module was created for |
| template_version | 1.0 | The version of the template that was created |
