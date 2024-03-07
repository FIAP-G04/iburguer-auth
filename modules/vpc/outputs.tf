output "vpc_id" {
    value = data.aws_vpc.vpc.id 
}

output "subnet_ids" {
  value = data.aws_subnets.available-subnets.ids
}

output "private_subnet_ids" {
  value = data.aws_subnets.private-subnets.ids
}

output "security_group_id" {
  value = data.aws_security_groups.vpc-sg.ids
}