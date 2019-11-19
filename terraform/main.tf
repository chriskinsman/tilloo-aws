provider "aws" {
  region  = "us-west-2"
  profile = "personal"
}

resource "aws_vpc" "tilloo" {
  cidr_block           = "${local.tilloo_cidr_block}"
  enable_dns_hostnames = true

  tags = {
    Name = "tilloo"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.tilloo.id}"

  tags = {
    Name = "tilloo"
  }
}

resource "aws_route" "public_gateway" {
  route_table_id         = "${aws_vpc.tilloo.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
  depends_on             = ["aws_vpc.tilloo"]
}

resource "aws_security_group_rule" "vpc" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "all"

  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  cidr_blocks = ["${local.tilloo_cidr_block}"]

  security_group_id = "${aws_vpc.tilloo.default_security_group_id}"
}

#data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnet_a" {
  availability_zone = "us-west-2a"
  cidr_block        = "${local.tilloo_cidr_prefix}.0.0/18"
  vpc_id            = "${aws_vpc.tilloo.id}"

  tags = "${
    map(
     "Name", "terraform-eks-${local.cluster_name}-node",
     "kubernetes.io/cluster/${local.cluster_name}", "shared",
     "kubernetes.io/role/alb-ingress", "",
     "kubernetes.io/role/elb", "",
     "kubernetes.io/role/internal-elb", ""
    )
  }"
}

resource "aws_route_table_association" "route_a" {
  subnet_id      = "${aws_subnet.subnet_a.id}"
  route_table_id = "${aws_vpc.tilloo.default_route_table_id}"
}

resource "aws_subnet" "subnet_b" {
  availability_zone = "us-west-2b"
  cidr_block        = "${local.tilloo_cidr_prefix}.64.0/18"
  vpc_id            = "${aws_vpc.tilloo.id}"

  tags = "${
    map(
     "Name", "terraform-eks-${local.cluster_name}-node",
     "kubernetes.io/cluster/${local.cluster_name}", "shared",
     "kubernetes.io/role/alb-ingress", "",
     "kubernetes.io/role/elb", "",
     "kubernetes.io/role/internal-elb", ""
    )
  }"
}

resource "aws_route_table_association" "route_b" {
  subnet_id      = "${aws_subnet.subnet_b.id}"
  route_table_id = "${aws_vpc.tilloo.default_route_table_id}"
}

resource "aws_subnet" "subnet_c" {
  availability_zone = "us-west-2c"
  cidr_block        = "${local.tilloo_cidr_prefix}.128.0/18"
  vpc_id            = "${aws_vpc.tilloo.id}"

  tags = "${
    map(
     "Name", "terraform-eks-${local.cluster_name}-node",
     "kubernetes.io/cluster/${local.cluster_name}", "shared",
     "kubernetes.io/role/alb-ingress", "",
     "kubernetes.io/role/elb", "",
     "kubernetes.io/role/internal-elb", ""
    )
  }"
}

resource "aws_route_table_association" "route_c" {
  subnet_id      = "${aws_subnet.subnet_c.id}"
  route_table_id = "${aws_vpc.tilloo.default_route_table_id}"
}

resource "aws_subnet" "subnet_d" {
  availability_zone = "us-west-2d"
  cidr_block        = "${local.tilloo_cidr_prefix}.192.0/18"
  vpc_id            = "${aws_vpc.tilloo.id}"

  tags = "${
    map(
     "Name", "terraform-eks-${local.cluster_name}-node",
     "kubernetes.io/cluster/${local.cluster_name}", "shared",
     "kubernetes.io/role/alb-ingress", "",
     "kubernetes.io/role/elb", "",
     "kubernetes.io/role/internal-elb", ""
    )
  }"
}

resource "aws_route_table_association" "route_d" {
  subnet_id      = "${aws_subnet.subnet_d.id}"
  route_table_id = "${aws_vpc.tilloo.default_route_table_id}"
}

resource "aws_iam_policy" "ingress-policy" {
  name        = "${local.cluster_name}-ingress-iam-policy"
  path        = "/"
  description = "Ingress policy for ALB"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "acm:DescribeCertificate",
                "acm:ListCertificates",
                "acm:GetCertificate"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:CreateSecurityGroup",
                "ec2:CreateTags",
                "ec2:DeleteTags",
                "ec2:DeleteSecurityGroup",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAddresses",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeTags",
                "ec2:DescribeVpcs",
                "ec2:ModifyInstanceAttribute",
                "ec2:ModifyNetworkInterfaceAttribute",
                "ec2:RevokeSecurityGroupIngress"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:AddListenerCertificates",
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:CreateLoadBalancer",
                "elasticloadbalancing:CreateRule",
                "elasticloadbalancing:CreateTargetGroup",
                "elasticloadbalancing:DeleteListener",
                "elasticloadbalancing:DeleteLoadBalancer",
                "elasticloadbalancing:DeleteRule",
                "elasticloadbalancing:DeleteTargetGroup",
                "elasticloadbalancing:DeregisterTargets",
                "elasticloadbalancing:DescribeListenerCertificates",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DescribeRules",
                "elasticloadbalancing:DescribeSSLPolicies",
                "elasticloadbalancing:DescribeTags",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetGroupAttributes",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:ModifyListener",
                "elasticloadbalancing:ModifyLoadBalancerAttributes",
                "elasticloadbalancing:ModifyRule",
                "elasticloadbalancing:ModifyTargetGroup",
                "elasticloadbalancing:ModifyTargetGroupAttributes",
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:RemoveListenerCertificates",
                "elasticloadbalancing:RemoveTags",
                "elasticloadbalancing:SetIpAddressType",
                "elasticloadbalancing:SetSecurityGroups",
                "elasticloadbalancing:SetSubnets",
                "elasticloadbalancing:SetWebACL"
             ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole",
                "iam:GetServerCertificate",
                "iam:ListServerCertificates"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cognito-idp:DescribeUserPoolClient"
            ],
            "Resource": "*"
        },        
        {
            "Effect": "Allow",
            "Action": [
                "waf-regional:GetWebACLForResource",
                "waf-regional:GetWebACL",
                "waf-regional:AssociateWebACL",
                "waf-regional:DisassociateWebACL"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "tag:GetResources",
                "tag:TagResources"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "waf:GetWebACL"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "route53-policy" {
  name        = "${local.cluster_name}-route53-iam-policy"
  path        = "/"
  description = "Ingress policy for ALB"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": [
                "arn:aws:route53:::hostedzone/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
POLICY
}

#
# IAM Roles to contact AWS Services
#

resource "aws_iam_role" "control-plane-roles" {
  name = "${local.cluster_name}-cluster-control-plane"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.control-plane-roles.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.control-plane-roles.name}"
}

#
# EKS Master Cluster Security Group
#
resource "aws_security_group" "control-plane-securitygroup" {
  name        = "${local.cluster_name}-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.tilloo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-${local.cluster_name}"
  }
}

# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
resource "aws_security_group_rule" "ingress-workstation-https" {
  cidr_blocks       = ["24.75.235.0/24"]
  description       = "Allow Workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.control-plane-securitygroup.id}"
  to_port           = 443
  type              = "ingress"
}

#
# EKS Master Cluster / Control Plane
#

resource "aws_eks_cluster" "cluster" {
  name     = "${local.cluster_name}"
  version  = "${local.k8s_version}"
  role_arn = "${aws_iam_role.control-plane-roles.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.control-plane-securitygroup.id}"]

    subnet_ids = [
      "${aws_subnet.subnet_a.id}",
      "${aws_subnet.subnet_b.id}",
      "${aws_subnet.subnet_c.id}",
      "${aws_subnet.subnet_d.id}",
    ]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.AmazonEKSServicePolicy",
  ]
}

#
# EKS Nodes
#

resource "aws_iam_role" "node-roles" {
  name = "${local.cluster_name}-cluster-nodes"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.node-roles.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.node-roles.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.node-roles.name}"
}

resource "aws_iam_role_policy_attachment" "ALBIngressPolicy" {
  policy_arn = "${aws_iam_policy.ingress-policy.arn}"
  role       = "${aws_iam_role.node-roles.name}"
}

resource "aws_iam_role_policy_attachment" "Route53IngressPolicy" {
  policy_arn = "${aws_iam_policy.route53-policy.arn}"
  role       = "${aws_iam_role.node-roles.name}"
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "${local.cluster_name}-instance-profile"
  role = "${aws_iam_role.node-roles.name}"
}

#
# Node Security Groups
#

resource "aws_security_group" "node-securitygroup" {
  name        = "${local.cluster_name}-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${aws_vpc.tilloo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "${local.cluster_name}-node",
     "kubernetes.io/cluster/${local.cluster_name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.node-securitygroup.id}"
  source_security_group_id = "${aws_security_group.node-securitygroup.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.node-securitygroup.id}"
  source_security_group_id = "${aws_security_group.control-plane-securitygroup.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.control-plane-securitygroup.id}"
  source_security_group_id = "${aws_security_group.node-securitygroup.id}"
  to_port                  = 443
  type                     = "ingress"
}

#
# Get AMI to use
#

data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${local.k8s_version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

#
# Node AutoScale Group
#

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# We set the DNS to a node-local-dns instance to avoid conntrack issue with cross node DNS resolution
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority.0.data}' --kubelet-extra-args '--node-labels=nodegroup=worker --cluster-dns=169.254.20.10' '${local.cluster_name}'
USERDATA
}

resource "aws_launch_configuration" "node" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.instance-profile.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "${local.worker_instance_type}"
  name_prefix                 = "eks-${local.cluster_name}"
  security_groups             = ["${aws_security_group.node-securitygroup.id}", "${aws_vpc.tilloo.default_security_group_id}"]
  user_data_base64            = "${base64encode(local.node-userdata)}"
  key_name                    = "Default"

  root_block_device {
    volume_type = "gp2"
    volume_size = 40
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity     = "${local.worker_desired_capacity}"
  launch_configuration = "${aws_launch_configuration.node.id}"
  max_size             = "${local.worker_max_size}"
  min_size             = "${local.worker_min_size}"
  name                 = "eks-${local.cluster_name}"

  vpc_zone_identifier = [
    "${aws_subnet.subnet_a.id}",
    "${aws_subnet.subnet_b.id}",
    "${aws_subnet.subnet_c.id}",
    "${aws_subnet.subnet_d.id}",
  ]

  tag {
    key                 = "Name"
    value               = "eks-${local.cluster_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${local.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}

#
# Kubectl config to setup control plan to accept IAM auth from nodes
#
# Run terraform output config_map_aws_auth and save the configuration into a file, e.g. config_map_aws_auth.yaml
# Run kubectl apply -f config_map_aws_auth.yaml
# You can verify the worker nodes are joining the cluster via: kubectl get nodes --watch
#

locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.node-roles.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}
