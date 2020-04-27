resource "aws_security_group" "backend" {
  name        = "Backend"
  description = "Backend Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow ssh in from internal"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  egress {
    description = "Allow any out"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "Backend"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}

resource "aws_instance" "backend" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend.id]
  subnet_id              = aws_subnet.private.id
  key_name               = aws_key_pair.sshkey.key_name

  tags = {
    Name      = "Backend"
    Workspace = terraform.workspace
    Project   = local.Project
    Scenario  = local.Scenario
  }
}


