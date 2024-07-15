output "auditlog_mgmt_auth_url" {
  value       = tostring(jsondecode(btp_subaccount_service_binding.sk_auditlogmgmnt.credentials)["uaa"]["url"])
  description = "The auth URL for the auditlog management service binding."
  sensitive = true
}

output "auditlog_mgmt_client_id" {
  value       = tostring(jsondecode(btp_subaccount_service_binding.sk_auditlogmgmnt.credentials)["uaa"]["clientid"])
  description = "The client ID for the auditlog management service binding."
  sensitive = true
}

output "auditlog_mgmt_client_secret" {
  value       = tostring(jsondecode(btp_subaccount_service_binding.sk_auditlogmgmnt.credentials)["uaa"]["clientsecret"])
  description = "The client secret for the auditlog management service binding."
  sensitive   = true
}
