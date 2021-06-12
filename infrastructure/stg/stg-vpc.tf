resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ecs-app"
  }
}

resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1a"

  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "ecs-app-public-1a"
  }
}

resource "aws_subnet" "public_2a" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1c"

  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "ecs-app-public-2a"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.10.0/24"

  tags = {
    Name = "ecs-app-private-1a"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecs-app"
  }
}

resource "aws_eip" "nat_1a" {
  vpc = true

  tags = {
    Name = "ecs-app-natgw-1a"
  }
}

resource "aws_nat_gateway" "nat_1a" {
  subnet_id     = aws_subnet.public_1a.id
  allocation_id = aws_eip.nat_1a.id

  tags = {
    Name = "ecs-app-nat"
  }
}
