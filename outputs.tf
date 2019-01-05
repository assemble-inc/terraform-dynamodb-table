output "table_arn" {
  value = "${aws_dynamodb_table.dynamo_table.arn}"
}

output "policy_arn" {
  value = "${aws_iam_policy.dynamodb_policy.arn}"
}
