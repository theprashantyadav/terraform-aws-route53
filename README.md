<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AWS Route53
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Terraform module to create Route53 resource on AWS for zone and record set.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/terraform-v0.15-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-aws-route53'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+Route53&url=https://github.com/clouddrove/terraform-aws-route53'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AWS+Route53&url=https://github.com/clouddrove/terraform-aws-route53'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 

- [Terraform 0.13](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-aws-route53/releases).


Here are some examples of how you can use this module in your inventory structure:
### Public Hostedzone
```hcl
  module "route53" {
    source        = "clouddrove/route53/aws"
    version       = "0.15.0"
    name           = "route53"
    application    = "clouddrove"
    environment    = "test"
    label_order    = ["environment", "name"]
    public_enabled = true
    record_enabled = true
    domain_name    = "clouddrove.com"
    names          = [
                      "www.",
                      "admin."
                    ]
    types          = [
                      "A",
                      "CNAME"
                    ]
    alias          = {
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
```
### Private Hostedzone
```hcl
  module "route53" {
    source        = "clouddrove/route53/aws"
    version       = "0.15.0"
    name            = "route53"
    application     = "clouddrove"
    environment     = "test"
    label_order     = ["environment", "name"]
    private_enabled = true
    record_enabled  = true
    domain_name     = "clouddrove.com"
    vpc_id          = "vpc-xxxxxxxxxxxxx"
    names           = [
                      "www.",
                      "admin."
                     ]
    types           = [
                      "A",
                      "CNAME"
                     ]
    ttls            = [
                      "3600",
                      "3600",
                     ]
    values          = [
                      "10.0.0.27",
                      "mydomain.com",
                     ]
  }
```
### Vpc Association
```hcl
  module "route53" {
    source        = "clouddrove/route53/aws"
    version       = "0.15.0"
    name                 = "route53"
    application          = "clouddrove"
    environment          = "test"
    label_order          = ["environment", "name"]
    private_enabled      = true
    enabled              = true
    domain_name          = "clouddrove.com"
    vpc_id               = "vpc-xxxxxxxxxxxxx"
    secondary_vpc_id     = "vpc-xxxxxxxxxxxxx"
    secondary_vpc_region = "eu-west-1"
  }
```






## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias | An alias block. Conflicts with ttl & records. Alias record documented below. | `map(any)` | <pre>{<br>  "evaluate_target_healths": [],<br>  "names": [],<br>  "zone_ids": []<br>}</pre> | no |
| allow\_overwrites | Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments. | `list(any)` | `[]` | no |
| application | Application (e.g. `cd` or `clouddrove`). | `string` | `""` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| comment | A comment for the hosted zone. Defaults to 'Managed by Terraform'. | `string` | `""` | no |
| delegation\_set\_id | The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones. | `string` | `""` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| domain\_name | This is the name of the resource. | `string` | n/a | yes |
| enabled | Whether to create Route53 vpc association. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| failover\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| failover\_routing\_policies | A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. Documented below. | `any` | `null` | no |
| force\_destroy | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `true` | no |
| geolocation\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| geolocation\_routing\_policies | A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. Documented below. | `any` | `null` | no |
| health\_check\_ids | The health check the record should be associated with. | `list(any)` | `[]` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| latency\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| latency\_routing\_policies | A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. Documented below. | `any` | `null` | no |
| managedby | ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'. | `string` | `"anmol@clouddrove.com"` | no |
| multivalue\_answer\_routing\_policies | Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy. | `list(any)` | `[]` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| names | The name of the record. | `list(any)` | `[]` | no |
| private\_enabled | Whether to create private Route53 zone. | `bool` | `false` | no |
| public\_enabled | Whether to create public Route53 zone. | `bool` | `false` | no |
| record\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| record\_set\_enabled | Whether to create seperate Route53 record set. | `bool` | `false` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-route53"` | no |
| secondary\_vpc\_id | The VPC to associate with the private hosted zone. | `string` | `""` | no |
| secondary\_vpc\_region | The VPC's region. Defaults to the region of the AWS provider. | `string` | `""` | no |
| set\_identifiers | Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below. | `list(any)` | `[]` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| ttls | (Required for non-alias records) The TTL of the record. | `list(any)` | `[]` | no |
| types | The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. | `list(any)` | `[]` | no |
| values | (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add "" inside the Terraform configuration string (e.g. "first255characters""morecharacters"). | `list(any)` | `[]` | no |
| vpc\_id | VPC ID. | `string` | `""` | no |
| weighted\_enabled | Whether to create Route53 record set. | `bool` | `false` | no |
| weighted\_routing\_policies | A block indicating a weighted routing policy. Conflicts with any other routing policy. Documented below. | `any` | `null` | no |
| zone\_id | Zone ID. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| tags | A mapping of tags to assign to the resource. |
| zone\_id | The Hosted Zone ID. This can be referenced by zone records. |




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-aws-route53/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-aws-route53)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
