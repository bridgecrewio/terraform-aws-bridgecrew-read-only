provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      module = "terraform-aws-bridgecrew-read-only"
    }
  }
}
