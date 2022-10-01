resource "aws_lb" "test" {
  name               = "project-lb"
  internal           = false
  load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [data.aws_subnet.public-1.id,data.aws_subnet.public-2.id]

}