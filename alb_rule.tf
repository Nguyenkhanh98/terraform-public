
resource "aws_lb_listener_rule" "onair_fe_https_rule" {
  listener_arn = aws_lb_listener.onair_https_listener.arn
  priority     = 1


  condition {
    host_header {
      values = ["onair.today"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.onair_fe_tg.arn
  }
}


resource "aws_lb_listener_rule" "onair_host_https_rule" {
  listener_arn = aws_lb_listener.onair_https_listener.arn
  priority     = 30

  condition {
    host_header {
      values = ["host.onair.today"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.onair_host_tg.arn
  }
}



resource "aws_lb_listener_rule" "onair_admin_https_rule" {
  listener_arn = aws_lb_listener.onair_https_listener.arn
  priority     = 2

  condition {
    host_header {
      values = ["admin.onair.today"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.onair_admin_tg.arn
  }
}

