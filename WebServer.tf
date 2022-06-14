#-----------------------------------------------
# Apache Web Server
#
# Build WebServer with httpd bootstrap action
#----------------------------------------------
#

resource "aws_default_vpc" "default" {}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_default_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = cidrsubnet(aws_default_vpc.default.cidr_block, 8, 1)
  tags = {
    Name = "subnet-1"
  }
}

resource "aws_security_group" "WebServerSG" {
  name = "Web Server Security Group"
  dynamic "ingress" {
    for_each = var.web_allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "WebServerApacheSG"
  }
}

resource "aws_instance" "WebServer" {
  ami                         = data.aws_ami.fresh_amazon_linux.id # Amazon Linux 2 Kernel 5.10 AMI 2.0.20220426.0 x86_64 HVM gp2
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.WebServerSG.id]
  availability_zone           = data.aws_availability_zones.available.names[0]
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet1.id
  associate_public_ip_address = true
  user_data                   = file("tf-app-server-script.sh")
  tags = {
    Name = "Web Server "
  }
}
