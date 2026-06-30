resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(local.module_tags, {
    Name = "${var.name_prefix}-nat-eip"
  })
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0]

  tags = merge(local.module_tags, {
    Name = "${var.name_prefix}-natgw"
  })
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = merge(local.module_tags, {
    Name = "${var.name_prefix}-private-rt"
  })
}

resource "aws_route_table_association" "private" {

  count = length(var.private_subnet_ids)

  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_rt.id
}