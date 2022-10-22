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
