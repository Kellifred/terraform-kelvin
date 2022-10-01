resource "aws_security_group" "ec2_sg" {
  name        = "allow_access"
  description = "Allow access inbound traffic"
  vpc_id      = data.aws_vpc.project-1.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["130.45.111.64/32","203.122.33.130/32","122.177.104.104/32","122.177.48.115/32","159.224.220.241/32"]
  }
   ingress {
    description      = "rds from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["130.45.111.64/32","203.122.33.130/32","122.177.104.104/32","122.177.48.115/32","159.224.220.241/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}