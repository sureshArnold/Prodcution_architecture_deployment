vpc_name = "DevOps_VPC"

cidr_block = "10.0.0.0/16"

/* List of subnets with cidr and az to be deployed in the vpc
public_subnets = [{cidr = "10.0.1.0/24", az = 'us-east-1a'},{cidr = "10.0.2.0/24", az = 'us-east-1b'}]
private_subnets = [{cidr = "10.0.3.0/24", az = 'us-east-1a'},{cidr = "10.0.4.0/24", az = 'us-east-1b'}]
 */
 

public_subnets = ["10.0.1.0/24","10.0.2.0/24" ]
private_subnets = ["10.0.3.0/24","10.0.4.0/24" ]