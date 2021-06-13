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

resource "aws_vpc_endpoint" "ecr-api" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group_rule.sg-rule-vpc.id,
  ]

  subnet_ids = [aws_subnet.private_1a.id]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group_rule.sg-rule-vpc.id,
  ]

  subnet_ids = [aws_subnet.private_1a.id]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "sample-s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  route_table_ids = [aws_route_table.sample-private.id]
}
