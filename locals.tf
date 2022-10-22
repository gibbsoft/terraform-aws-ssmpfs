locals {
  num_blocks = floor((length(split("", var.value)) / var.block_size) + (length(split("", var.value)) % var.block_size > 0 ? 1 : 0))
}
