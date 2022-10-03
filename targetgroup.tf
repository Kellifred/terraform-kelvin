resource "aws_lb_target_group" "protradenet-tg-1" {
  name     = "protradenet-tg-1"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.protradenet_vpc.id
}


resource "aws_lb_target_group" "protradenet-tg-2" {
  name     = "protradenet-tg-2"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.protradenet_vpc.id
}


resource "aws_lb_target_group_attachment" "protr_tg_attach-1" {
  target_group_arn = aws_lb_target_group.protradenet-tg-1.arn
  target_id        = aws_instance.protradenet-1.id
  port             = 443
}

resource "aws_lb_target_group_attachment" "protr_tg_attach-2" {
  target_group_arn = aws_lb_target_group.protradenet-tg-2.arn
  target_id        = aws_instance.protradenet-2.id
  port             = 443
}