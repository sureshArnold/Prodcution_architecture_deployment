resource "aws_lb" "main" {
    name = var.lb_name
    internal = var.lb_internal
    load_balancer_type = var.lb_type
    security_groups = concat(list(aws_security_group.lb_sg[0].id), var.lb_security_group_id)
    subnets = var.lb_internal ? data.terraform_state.vpc.outputs.private_subnets : data.terraform_remote_state.vpc.outputs.public_subnets
}


resource "aws_alb_listener" "main" {
    load_balancer_arn = aws_lb.main.arn
    port = lookup(var.lb_listener, "port", 80)
    protocol = lookup(var.lb_listener, "protocol", "HTTP")
    certificate_arn = lookup(var.lb_listener, "protocol") == "HTTPS" ? lookup(var.lb_listener, "certificate_arn","") : ""
    ssl_policy = lookup(var.lb_listener, "ssl_policy") == "HTTPS" ? lookup(var.lb_listener, "ssl_policy", "") : ""

    default_action {
        type = forward
        target_group_arn = aws_alb_target_group.tg1.main[0].arn
    }
}

resource "aws_alb_target_group" "main" {
    name = var.lb_target_group_name
    port = lookup(var.lb_target_group,"port", 80)
    protocol = lookup(var.lb_target_group, "protocol", "HTTP")
    target_type = lookup(var.lb_target_group,"target_type","instance")
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    deregistration_delay = lookup(var.lb_target_group, "deregistration_delay",300)

    health_check{
        path = lookup(var.lb_health_check, "path","/")
        healthy_threshold = lookup(var.lb_health_check, "health_threshold", 3)
        unhealthy_threshold = lookup(var.lb_health_check, "unhealthy_threshold", 2)
        interval = lookup(var.lb_health_check, "interval",30)
        timeout = lookup(var.lb_health_check, "timeout", 5)
        matcher = lookup(var.lb_health_check, "matcher", 200)
    }
    
}

resource "aws_alb_target_group_attachment" "tg_attachment"{
    
    for_each = toset(data.terraform_remote_state.outputs.instance_private_ip)
    target_group_arn = aws_alb_target_group.main.arn
    target_id = instance_private_ip.value
    depends_on = [aws_alb_target_group.main]
}




