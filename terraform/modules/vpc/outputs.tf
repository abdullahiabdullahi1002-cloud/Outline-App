output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.outline-vpc.id
}

output "public_subnet_1_id" {
  description = "Subnet 1 ID"
  value       = aws_subnet.public-subnet-1.id
}

output "public_subnet_2_id" {
  description = "Subnet 2 ID"
  value       = aws_subnet.public-subnet-2.id
}

output "private_subnet_1_id" {
  description = "Private Subnet 1 ID"
  value       = aws_subnet.private-subnet-1.id
}

output "private_subnet_2_id" {
  description = "Private Subnet 2 ID"
  value       = aws_subnet.private-subnet-2.id
}

output "internet_gateway" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.outline-igw.id
}
