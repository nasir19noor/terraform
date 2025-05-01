locals {
  availability_zones = [
    for i in range(var.subnet_count) : 
    "${var.region}${["a", "b", "c", "d", "e", "f"][i % 6]}"
  ]
}

resource "aws_subnet" "this" {
  count             = var.subnet_count
  vpc_id            = var.vpc_id
  cidr_block        = element(var.cidr_blocks, count.index)
  availability_zone = element(local.availability_zones, count.index)

  tags = merge(
    var.tags,
    {
      Name = "${lookup(var.tags, "Name", "subnet")}-${count.index + 1}"
    }
  )
}