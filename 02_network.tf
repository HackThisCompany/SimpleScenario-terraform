######  MAIN NETWORK ######
resource "aws_vpc" "main" {
  cidr_block          = "10.0.0.0/16"

  tags = {
    Name      = local.Scenario
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name = local.domain_name
  tags = {
    Name      = local.Scenario
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}
resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}

######  PUBLIC SUBNET ######
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name      = "Public"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "Public"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name      = "Public"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


######  PRIVATE SUBNET ######
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name      = "Private"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "Private"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
resource "aws_main_route_table_association" "vpc_main_route_table" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.private.id
}
