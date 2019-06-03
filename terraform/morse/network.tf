resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc_main.id}"

  tags {
    Name = "igw-${var.region}"
  }
}

resource "aws_subnet" "public" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.vpc_main.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc_main.cidr_block, 8, count.index)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
  tags {
    Name = "public-subnet-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

resource "aws_route_table" "public_rt" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.vpc_main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "public-rt-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

resource "aws_route_table_association" "public_rta" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public_rt.*.id, count.index)}"
}
