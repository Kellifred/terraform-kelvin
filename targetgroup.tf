resource "aws_lb_target_group" "tg-1" {
  name     = "project-1"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.project-1.id
}


resource "aws_lb_target_group" "tg-2" {
  name     = "project-2"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.project-1.id
}


resource "aws_lb_target_group_attachment" "attache-1" {
  target_group_arn = aws_lb_target_group.tg-1.arn
  target_id        = aws_instance.project-1.id
  port             = 443
}

resource "aws_lb_target_group_attachment" "attache-2" {
  target_group_arn = aws_lb_target_group.tg-2.arn
  target_id        = aws_instance.project-2.id
  port             = 443
}