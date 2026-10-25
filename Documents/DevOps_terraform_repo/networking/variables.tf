variable "vpc_name" {
    type = string
}

variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    type = list(string)
    default=[]
}

/* variable "public_subnets"{
    description = "List of public subnets with cidr and az to be deployed in the vpc"
    type = list(objects{
        cidr = string
        az string
    })
    default=[]
} */

variable "private_subnets"{
    type = list(string)
    default=[]
}

/* variable "private_subnets"{
    description = "List of private subnets with cidr and az to be deployed in the vpc"

    type = list(objects{
        cidr = string
        az string
    })
    default=[]
} */

variable "az_id"{
    type =list(string)
    default = []
}

variable "workspace_path"{
    type = string
    default = "not set"
}
