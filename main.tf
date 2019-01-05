locals {
  attributes = [
    {
      name = "${var.range_key}"
      type = "S"
    },
    {
      name = "${var.hash_key}"
      type = "S"
    },
    "${var.dynamodb_attributes}",
  ]

  # Use the `slice` pattern (instead of `conditional`) to remove the first map from the list if no `range_key` is provided
  # Terraform does not support conditionals with `lists` and `maps`: aws_dynamodb_table.default: conditional operator cannot be used with list values
  from_index = "${length(var.range_key) > 0 ? 0 : 1}"

  attributes_final = "${slice(local.attributes, local.from_index, length(local.attributes))}"
}

resource "aws_dynamodb_table" "dynamo_table" {
  name           = "${var.table_name}"
  read_capacity  = "${var.read_capacity}"
  write_capacity = "${var.write_capacity}"
  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"

  server_side_encryption {
    enabled = "${var.enable_encryption}"
  }

  point_in_time_recovery {
    enabled = "${var.enable_point_in_time_recovery}"
  }

  lifecycle {
    ignore_changes = ["read_capacity", "write_capacity"]
  }

  attribute              = ["${local.attributes_final}"]
  global_secondary_index = ["${var.global_secondary_index}"]
  tags                   = "${var.tags}"
}

data "aws_iam_policy_document" "dynamodb_policy_document" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:PutItem",
      "dynamodb:Scan",
    ]

    effect    = "Allow"
    resources = ["${aws_dynamodb_table.dynamo_table.arn}"]
  }
}

resource "aws_iam_policy" "dynamodb_policy" {
  name        = "dynamodb_policy_${aws_dynamodb_table.dynamo_table.name}"
  description = "Dynamodb Read Write permissions"

  policy = "${data.aws_iam_policy_document.dynamodb_policy_document.json}"
}
