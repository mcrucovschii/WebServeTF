#-----------------------------------------------
# Apache Web Server
#
# Build WebServer at bootstrap_action
#----------------------------------------------

/*
resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.0.0.0/16"
}
*/

resource "aws_default_vpc" "default" {}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_default_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = cidrsubnet(aws_default_vpc.default.cidr_block, 4, 1)
  tags = {
    Name = "subnet-1"
  }
}

resource "aws_instance" "WebServer" {
  ami                         = data.aws_ami.fresh_amazon_linux.id # Amazon Linux 2 Kernel 5.10 AMI 2.0.20220426.0 x86_64 HVM gp2
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.WebServerSG.id]
  availability_zone           = data.aws_availability_zones.available.names[0]
  key_name                    = var.key_max_name #"MaxKeyPairDel"
  subnet_id                   = aws_subnet.subnet1.id
  associate_public_ip_address = true
  # vpc
  user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with ip: $myip </h2><br>Build by Terraform" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
  tags = {
    Name = "Web Server Apache"
  }
}

resource "aws_security_group" "WebServerSG" {
  name = "Web Server Security Group"
  # vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "WebServerApacheSG"
  }
}
