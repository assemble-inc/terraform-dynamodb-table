# DynamoDB Terraform Module

This is a convenience module for AWS DynamoDB

## Usage

```tf
module "user_table" {
  source     = "assemble-inc/dynamodb/table"
  table_name = "User"
  hash_key   = "ID"

  dynamodb_attributes = [
    {
      name = "ID"
      type = "S"
    },
  ]
}
```

## Inputs

- **table_name**: Table name
- **read_capacity**: Read capacity
- **write_capacity**: Write capacity
- **enable_encryption**: Encryption enabled _(Default: true)_
- **enable_point_in_time_recovery**: Enable point in time recovery _(Default: true)_
- **hash_key**: Hash key
- **range_key**: Range key
- **dynamodb_attributes**: Attributes list
- **global_secondary_index**: Global secondary index list
- **tags**: Tags map

## Outputs

- **table_arn**: Dynamo Table ARN
- **policy_arn**: Dynamo Policy ARN
