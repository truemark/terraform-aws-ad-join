output "role_arn" {
  description = "The ARN's present in the Active Directory ad_join roles."
  value = join("", aws_iam_role.ad_join.*.arn)
}

output "role_name" {
  description = "The names present in the Active Directory ad_join roles."
  value = join("", aws_iam_role.ad_join.*.name)
}

output "role_id" {
  description = "The IDs present in the Active Directory ad_join roles."
  value = join("", aws_iam_role.ad_join.*.id)
}

output "document_id" {
  description = "The policy id's of the Active Directory ad_join roles."
  value = join("", aws_ssm_document.ad_join.*.id)
}

output "document_name" {
  description = "The policy names of the Active Directory ad_join roles."
  value = join("", aws_ssm_document.ad_join.*.name)
}

output "document_arn" {
  description = "The policy ARN's of the Active Directory ad_join roles."
  value = join("", aws_ssm_document.ad_join.*.arn)
}
