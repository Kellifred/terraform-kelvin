resource "aws_lb" "protradenet-alb" {
  name               = "protradenet-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.protradenet-alb-sg.id]
  subnets            = [data.aws_subnet.protradenet_public-1.id,data.aws_subnet.protradenet_public-2.id]
}
resource "aws_security_group" "protradenet-alb-sg" {
  name        = "protradenet-alb-sg"
  description = "Allow access inbound traffic"
  vpc_id      = data.aws_vpc.protradenet_vpc.id

 ingress {
  description      = "http"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
 }
  tags = {
    Name = "protradenet_sg-alb"
  }
}

resource "aws_lb_listener" "protradenet-listener-1" {
  load_balancer_arn = aws_lb.protradenet-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
  type             = "forward"
  forward {
  target_group {
  arn = aws_lb_target_group.protradenet-tg-1.arn
  }

  target_group {
  arn =  aws_lb_target_group.protradenet-tg-2.arn
  }
  }
  }
}
  
