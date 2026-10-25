resource "aws_vpc" "vpc1" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"

    tags = {
        Name = var.vpc_name
        workspace = var.workspace_path
    }
}

resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.vpc1.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = var.az_id[count.index]

    # If we want to deploy certain no of subnets in across mutiple az's, we can use the below code
    # cidr_block = var.private_subnets[count.index].cidr
    # availability_zone = var.private_subnets[count.index].az

    tags={
        name = "{var.vpc_name}-public-subnet-[count.index + 1]"
    }
}



resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.vpc1.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = var.az_id[count.index]

    # If we want to deploy certain no of subnets in across mutiple az's, we can use the below code.
    # cidr_block = var.private_subnets[count.index].cidr
    # availability_zone = var.private_subnets[count.index].az



    tags ={
        name = "{var.vpc_name}-private-subnet-[count.index + 1]"
    }
}



resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc1.id

    tags ={
        name = "{var.vpc_name}-igw"
    }
}

resource "aws_internet_gateway_attachment" "igw_attachment"{
    internet_gateway_id = aws_internet_gateway.igw.id
    vpc_id = aws_vpc.vpc1.id
}

resource "aws_nat_gateway" "nat_gw" {
    count = length(var.az_id)
    connectivity_type = "private"
    subnet_id = aws_subnet.private_subnet[count.index].id
}

resource "aws_default_route_table" "public_route"{
    default_route_table_id = aws_vpc.vpc1.default_route_table.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        name = "{var.vpc_name}-public-route"
    }
}

resource "aws_route_table" "private_route"{
    count = length(var.private_subnets)
    vpc_id = aws_vpc.vpc1.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
    }

    tags = {
        name = "{var.vpc_name}-private-route"
    }

}

resource "aws_route_table_association" "public_subnet_association" {
    count = length(var.public_subnets)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_default_route_table.public_route.id
}

resource "aws_route_table_association" "private_subnet_association" {
    count = length(var.private_subnets)
    subnet_id = aws_subnet.prvivate_subnet[count.index].id
    route_table_id = aws_route_table.private_route.id
}

