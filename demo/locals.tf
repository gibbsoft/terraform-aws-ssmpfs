locals {
  text = "Hello World"

  # This generates a large arbitrary string 16k in size, image it's a cert chain or something.
  some_string = join("", [for v in split("", sha512(local.text)) : sha512(local.text)])
}