######################################################
#             --------VPC-------                    #
#####################################################

resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

   tags = merge({
    Name = var.vpc_name
  }, var.tags)
}

/*
 * internet gateway
 **/
resource "aws_internet_gateway" "igw" {

   depends_on = [ aws_vpc.my_vpc ]

  vpc_id = aws_vpc.my_vpc.id

  tags = merge({
    Name = "${var.vpc_name}-igw"
  }, var.tags)
}

######################################################
#            NAT GATEWAY                            #
#####################################################

resource "aws_eip" "nat" {
  
  tags = merge({
    Name = "${var.vpc_name}-nat-eip"
  }, var.tags)

}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  
  subnet_id     = element(aws_subnet.public[*].id, 0) # Using the first public subnet

  tags = merge({
    Name = "${var.vpc_name}-nat-gw"
  }, var.tags)

  depends_on = [aws_internet_gateway.igw]
}


######################################################
#          Create Subnets Public&Private            #
#####################################################

resource "aws_subnet" "public" {
  depends_on = [ aws_vpc.my_vpc ]

  count = length(var.public_subnets)

  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.public_subnets, count.index)

  map_public_ip_on_launch = true

  availability_zone = element(var.azs, count.index % length(var.azs))  //TODO:

  tags = merge({
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }, var.tags)
}

resource "aws_subnet" "private" {
  depends_on = [ aws_vpc.my_vpc ]

  count = length(var.private_subnets)

  vpc_id            = aws_vpc.my_vpc.id

  cidr_block        = element(var.private_subnets, count.index)  ## <----
 
  availability_zone = element(var.azs, count.index % length(var.azs))  

  tags = merge({
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }, var.tags)
}


######################################################
#          Route Tables                             #
#####################################################


resource "aws_route_table" "public" {

  depends_on = [ aws_vpc.my_vpc ]


  count = length(var.public_subnets)

  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "${var.vpc_name}-public-rt-${count.index + 1}"
  }, var.tags)
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = element(aws_route_table.public[*].id, count.index)
}

resource "aws_route_table" "private" {

  depends_on = [ aws_vpc.my_vpc ]

  count = length(var.private_subnets)

  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge({
    Name = "${var.vpc_name}-private-rt-${count.index + 1}"
  }, var.tags)
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.private[*].id, count.index)
}





