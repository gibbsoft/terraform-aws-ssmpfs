module "ssmpfs" {
  source = "../"
  name   = "/demo/ssmpfs_some_string"
  value  = local.some_string
}
