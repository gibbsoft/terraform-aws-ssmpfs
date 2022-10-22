# terraform-module-ssmpfs
# Copyright (C) 2020 Nigel Gibbs
#
# This file is part of terraform-module-ssmpfs.
#
# terraform-module-ssmpfs is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# terraform-module-ssmpfs is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with terraform-module-ssmpfs.  If not, see <https://www.gnu.org/licenses/>.

resource "aws_ssm_parameter" "ssmpfs" {
  count = local.num_blocks

  name  = local.num_blocks == 1 && var.disable_number_when_single_block ? var.name : format(var.format, var.name, count.index + 1, local.num_blocks)
  type  = var.type
  value = join("", slice(split("", var.value), count.index * var.block_size, count.index * var.block_size + var.block_size >= length(split("", var.value)) ? length(split("", var.value)) : count.index * var.block_size + var.block_size))
}
