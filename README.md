# SSMPFS (SSM Parameter Store File System)

A terraform module to allow storage of large-ish data in free-tier SSM
Parameter Store.  This can be handy for certificate chains, etc.

Free tier parameter store supports storage of individual 'parameters' up to the
somewhat restrictive maximum size of 4k whilst the advanced tier raises this
limit to 8k, for a price. According to [AWS Documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html) up to 10,000 SSM secrets
can be stored in the free tier, or 100,000 in the advanced tier.

This modules splits a larger input into smaller chunks and stores them across
multiple parameters, treating the parameter store almost like a filesystem.

## License

Released under the [GNU General Public License v3](https://github.com/gibbsoft/terraform-module-ssmpfs/blob/main/LICENSE) license.

## Demo

Take a look in the [demo](https://github.com/gibbsoft/terraform-module-ssmpfs/blob/main/demo) directory.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.ssmpfs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_size"></a> [block\_size](#input\_block\_size) | Max size of each block of data | `number` | `4096` | no |
| <a name="input_disable_number_when_single_block"></a> [disable\_number\_when\_single\_block](#input\_disable\_number\_when\_single\_block) | Disable format name with count when only one block is used | `bool` | `true` | no |
| <a name="input_format"></a> [format](#input\_format) | Format of parameter name in SSM Parameter | `string` | `"%s/%s-of-%s"` | no |
| <a name="input_name"></a> [name](#input\_name) | SSM Parameter name | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | n/a | `string` | `"SecureString"` | no |
| <a name="input_value"></a> [value](#input\_value) | Value to store in SSM Parameter | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_block_size"></a> [block\_size](#output\_block\_size) | Size of each block |
| <a name="output_name"></a> [name](#output\_name) | Base name of the SSM parameter used to store the value |
| <a name="output_num_blocks"></a> [num\_blocks](#output\_num\_blocks) | Number of blocks in SSM used to store the value |
| <a name="output_value"></a> [value](#output\_value) | SSMPFS value stored in SSM |

## Examples

Some examples are below:

### Example 1 : Chunked file

Due to the size (~10KB) of the file passed to `value` below, the module will store and retrieve
the it over 3 x 4k 'blocks':

```hcl
module "ssmpfs" {
  source = "./ssmpfs"
  name   = "/LoremIpsum"
  value  = file(pathexpand("~/sample_file_10KB.txt"))
}
```

Terraform plan would look like this:

```
Terraform will perform the following actions:

  # module.ssmpfs.aws_ssm_parameter.ssmpfs[0] will be created
  + resource "aws_ssm_parameter" "ssmpfs" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "/LoremIpsum/1-of-3"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.ssmpfs.aws_ssm_parameter.ssmpfs[1] will be created
  + resource "aws_ssm_parameter" "ssmpfs" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "/LoremIpsum/2-of-3"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.ssmpfs.aws_ssm_parameter.ssmpfs[2] will be created
  + resource "aws_ssm_parameter" "ssmpfs" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "/LoremIpsum/3-of-3"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
```

### Example 2 : Single parameter

In this example we store a very short 16 character secret into a single SSM
parameter.  Due to the small size, there is no need for it to be split into
chunks.  For single block parameters by default the module will not append
the count suffix:

```hcl
module "ssmpfs" {
  source = "./ssmpfs"
  name   = "/RandomPassword"
  value  = random_password.password.result
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
```

Terraform plan would look like this:

```
Terraform will perform the following actions:

  # module.ssmpfs.aws_ssm_parameter.ssmpfs[0] will be created
  + resource "aws_ssm_parameter" "ssmpfs" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "/RandomPassword"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```
<!-- END_TF_DOCS -->