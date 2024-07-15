variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}

variable "subaccount_id" {
  type        = string
  description = "The subaccount ID."
}


variable "create_key_file" {
  type        = bool
  description = "Switch to enable the creation of a file containing the service keys."
  default     = false
}
