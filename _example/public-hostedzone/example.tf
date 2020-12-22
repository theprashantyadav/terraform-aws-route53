provider "aws" {
  region = "eu-west-1"
}

module "route53" {
  source = "../../"

  name           = "route53"
  repository     = "https://registry.terraform.io/modules/clouddrove/route53/aws/0.14.0"
  environment    = "test"
  label_order    = ["name", "environment"]
  public_enabled = true
  record_enabled = true

  domain_name = "clouddrove.com"

  names = [
    "www.",
    "admin."
  ]
  types = [
    "A",
    "CNAME"
  ]
  alias = {
    names = [
      "d130easdflja734js.cloudfront.net"
    ]
    zone_ids = [
      "Z2FDRFHATA1ER4"
    ]
    evaluate_target_healths = [
      false
    ]
  }
}
