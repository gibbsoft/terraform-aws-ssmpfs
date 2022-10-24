### Example 1 : Chunked file

Due to the size (~10KB) of the file passed to `value` below, the module will store and retrieve
it over 3 x 4k 'blocks':

```hcl
module "ssmpfs" {
  source = "./ssmpfs"
  name   = "/LoremIpsum"
  value  = file(pathexpand("~/sample_file_10KB.txt"))
}
```

Terraform plan would look like this:

```text
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
