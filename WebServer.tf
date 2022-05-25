#-----------------------------------------------
# Apache Web Server
#
# Build WebServer at bootstrap_action
#----------------------------------------------

#resource "aws_vpc" "Main" {
#  cidr_block = "10.0.0.0/16"
#}

resource "aws_instance" "WebServer" {
  ami                    = "ami-02541b8af977f6cdd" # Amazon Linux 2 Kernel 5.10 AMI 2.0.20220426.0 x86_64 HVM gp2
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.WebServerSG.id]
  # vpc
  user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2>WebServer with ip: $myip</h2><br>Build by Terraform" > /var/www/html/index.html_url
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
  /*
  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
*/

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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
