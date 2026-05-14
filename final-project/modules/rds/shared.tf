
resource "aws_db_subnet_group" "default" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_private_ids

  tags = merge(var.tags, { Name = "${var.name}-subnet-group" })
}


resource "aws_security_group" "rds" {
  name        = "${var.name}-rds-sg"
  description = "Allow inbound traffic to RDS from VPC"
  vpc_id      = var.vpc_id


  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}