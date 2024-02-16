resource "aws_lb" "dev_web" {
  name               = "Terraform-dev-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dev_web_lb.id]
  subnets            = [data.terraform_remote_state.vpc.outputs.public_subnets[0], data.terraform_remote_state.vpc.outputs.public_subnets[1], data.terraform_remote_state.vpc.outputs.public_subnets[2]]
}

resource "aws_lb_target_group" "dev_web_tg" {
  name     = "Terraform-dev-web-tg"
  target_type        = "instance"
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
    target_group_arn = aws_lb_target_group.dev_web_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "dev_web" {
    target_group_arn = aws_lb_target_group.dev_web_tg.arn
    target_id        = data.terraform_remote_state.ec2.outputs.ec2_id 
    port             = 80
}