resource "aws_iam_role" "ad_join" {
  count = var.create_role ? 1 : 0
  name  = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = var.tags
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  name = "AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  count      = var.create_role ? 1 : 0
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
  role       = aws_iam_role.ad_join[count.index].name
}

data "aws_iam_policy" "AmazonSSMDirectoryServiceAccess" {
  name = "AmazonSSMDirectoryServiceAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonSSMDirectoryServiceAccess" {
  count      = var.create_role ? 1 : 0
  policy_arn = data.aws_iam_policy.AmazonSSMDirectoryServiceAccess.arn
  role       = aws_iam_role.ad_join[count.index].name
}

resource "aws_ssm_document" "ad_join" {
  count         = var.create_document && var.directory_id != "" && var.directory_name != "" && length(var.dns_ip_addresses) > 0 ? 1 : 0
  name          = var.document_name
  document_type = "Command"
  content       = <<DOC
  {
    "schemaVersion": "2.2",
    "description": "aws:domainJoin",
    "mainSteps": [
        {
          "action": "aws:domainJoin",
          "name":  "domainJoin",
          "inputs": {
            "directoryId": "${var.directory_id}",
            "directoryName": "${var.directory_name}",
            "dnsIpAddresses": ${jsonencode(var.dns_ip_addresses)}
          }
        }
      ]
  }
DOC
}

locals {
  tag_values = length(var.association_tag_values) == 0 ? [var.directory_name] : var.association_tag_values
}

resource "aws_ssm_association" "ad_join" {
  count = var.create_association && var.create_document ? 1 : 0
  name  = aws_ssm_document.ad_join[count.index].name
  targets {
    key    = "tag:${var.association_tag_name}"
    values = local.tag_values
  }
}


