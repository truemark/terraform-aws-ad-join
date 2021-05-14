output "role_arn" {
  value = join("", aws_iam_role.ad_join.*.arn)
}

output "role_name" {
  value = join("", aws_iam_role.ad_join.*.name)
}

output "role_id" {
  value = join("", aws_iam_role.ad_join.*.id)
}

output "document_id" {
  value = join("", aws_ssm_document.ad_join.*.id)
}

output "document_name" {
  value = join("", aws_ssm_document.ad_join.*.name)
}

output "document_arn" {
  value = join("", aws_ssm_document.ad_join.*.arn)
}
