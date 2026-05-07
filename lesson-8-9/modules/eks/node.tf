# IAM-роль для EC2-вузлів (Worker Nodes)
resource "aws_iam_role" "nodes" {
  # Ім'я ролі для вузлів
  name = "${var.cluster_name}-eks-nodes"

  # Політика, що дозволяє EC2 асумувати роль
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# Прив'язка політики для EKS Worker Nodes
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

# Прив'язка політики для Amazon VPC CNI плагіну
resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

# Прив'язка політики для читання з Amazon ECR
resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

# ДОДАНО: Прив'язка політики для ПУШУ в Amazon ECR (необхідно для Jenkins)
resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_power_user" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  role       = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "general" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "general"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = var.subnet_ids

  capacity_type  = "ON_DEMAND"
  instance_types = ["${var.instance_type}"]

  launch_template {
    name    = aws_launch_template.eks_nodes.name
    version = aws_launch_template.eks_nodes.latest_version
  }

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }


  # Конфігурація оновлення вузлів
  update_config {
    max_unavailable = 1 # Максимальна кількість вузлів, які можна оновлювати одночасно
  }

  # Додає мітки до вузлів
  labels = {
    role = "general" # Тег "role" зі значенням "general"
  }

  # Залежності для створення Node Group
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_power_user, 
  ]


  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}
resource "aws_launch_template" "eks_nodes" {
  name = "eks-nodes-metadata-fix"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional" 
    http_put_response_hop_limit = 2          
  }
}