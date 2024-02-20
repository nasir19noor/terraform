resource "aws_lb" "prod_be" {
  name               = "Terraform-prod-be-lb"
  internal           = true
  load_balancer_type = "network"
  security_groups    = [aws_security_group.prod_be_lb.id]
  subnets            = [data.terraform_remote_state.vpc.outputs.private_subnets[0], data.terraform_remote_state.vpc.outputs.private_subnets[1], data.terraform_remote_state.vpc.outputs.private_subnets[2]]
}

resource "aws_lb_target_group" "prod_be_tg" {
  name     = "Terraform-prod-be-tg"
  target_type        = "instance"
  port     = 80
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_lb_listener" "prod_be" {
  load_balancer_arn = aws_lb.prod_be.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_be_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "prod_be" {
    target_group_arn = aws_lb_target_group.prod_be_tg.arn
    target_id        = data.terraform_remote_state.ec2.outputs.ec2_id 
    port             = 80
}