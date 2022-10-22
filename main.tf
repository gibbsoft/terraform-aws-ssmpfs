resource "aws_ssm_parameter" "ssmpfs" {
  count = local.num_blocks

  name  = local.num_blocks == 1 && var.disable_number_when_single_block ? var.name : format(var.format, var.name, count.index + 1, local.num_blocks)
  type  = var.type
  value = join("", slice(split("", var.value), count.index * var.block_size, count.index * var.block_size + var.block_size >= length(split("", var.value)) ? length(split("", var.value)) : count.index * var.block_size + var.block_size))
}
