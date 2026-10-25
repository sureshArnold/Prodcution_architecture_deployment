variable "terraform_state_bucket" {
    description = "This variable defines s3 bucket where the exisitng terraform file is stored"
    type = string
    default = ""
}

variable "terraform_state_key" {
    description = "This variable defines the key for the terraform state file in the S3 bucket"
    type = string
    default = ""
}

variable "terraform_state_region" {
    description = "This variable defines the region of the terraform state bucket"
    type = string
    default = ""
}

variable "lb_type" {
    description = "This variable defines the type of load balancer to be deployed"
    type = string
    default = ""
}

variable "lb_name" {
    description = "This variable defines the name of the load balancer to be deployed"
    type = string
    default = ""
}

variable "lb_target_group_name" {
    description = "This variable defines the name of the target group to be deployed"
    type = string
    default = ""

}

variable "lb_target_group" {
    description = "This variable defines the parameters of the target group"
    type = map(string)
    default = {
        port = "80"
        protocol = "HTTP"
        target_type = "instance"
    }
}

variable "lb_health_check" {
    description = "This variable defines the parameters of the health checks to be performed on the target group"
    type = map(string)
    default = {
        path = "/"
        healthy_threshold = "3"
        unhealthy_threshold = "2"
        interval = "30"
        timeout = "5"
        matcher = "200"

    }

}


variable "lb_listener" {
    description = "This variable defines the parameters of the listner to be deployed"
    type = map(string)
    default = {
        port = "80"
        protocol = "HTTP"
        ssl_poliyc = "ELBSecurityPolicy-2016-08"
    }
}

variable "lb_internal" {
    description = "This variable defines whther it is an internal or external load balancer"
    type = bool
    default = false
}

variable "lb_security_group_id" {
    description = "This variable defines the security group ID for the load balancer"
    type = string
    default = ""
}
