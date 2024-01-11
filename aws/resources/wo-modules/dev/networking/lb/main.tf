resource "aws_lb" "dev_web" {
  name               = "${var.project}dev_web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dev_web_lb]
  subnets            = [data.terraform_remote_state.vpc.outputs.public_subnets[0], data.terraform_remote_state.vpc.outputs.public_subnets[1], data.terraform_remote_state.vpc.outputs.public_subnets[2]]
}

resource "aws_lb_target_group" "dev_web_tg" {
  name     = "${var.project}dev_web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_lb_listener" "dev_web" {
  load_balancer_arn = aws_lb.dev_web.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sdev_web_tg.arn
  }
}