variable "table_name" {
  type = "string"
}

variable "read_capacity" {
  default = 5
}

variable "write_capacity" {
  default = 5
}

variable "enable_encryption" {
  type    = "string"
  default = "true"
}

variable "enable_point_in_time_recovery" {
  type    = "string"
  default = "true"
}

variable "hash_key" {
  type = "string"
}

variable "range_key" {
  type    = "string"
  default = ""
}

variable "dynamodb_attributes" {
  type    = "list"
  default = []
}

variable "global_secondary_index" {
  type    = "list"
  default = []
}

variable "tags" {
  type = "map"
}
