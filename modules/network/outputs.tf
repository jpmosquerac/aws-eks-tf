output "aws_vpc" {
  value = aws_vpc.custom_vpc.id
}

output "private_subnet" {
  value = aws_subnet.private_subnet
}

output "public_subnet" {
  value = aws_subnet.public_subnet
}

output "public_sg" {
  value = aws_security_group.public_sg.id
}

output "data_plane_sg" {
  value = aws_security_group.data_plane_sg.id
}

output "control_plane_sg" {
  value = aws_security_group.control_plane_sg.id
}
