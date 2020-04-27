resource "aws_security_group" "frontend" {
  name        = "Frontend"
  description = "Frontend Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow ssh in"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow any out"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "Frontend"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}

resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.frontend.id]
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.sshkey.key_name

  tags = {
    Name      = "Frontend"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}


