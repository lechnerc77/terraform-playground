# The Audit log Management service is automatically entitled to the subaccount
resource "random_uuid" "uuid" {}

locals {
  service_name      = "auditlog-management"
  service_plan_name = "default"
  service_name_text = join("-", ["auditlogmgmnt", random_uuid.uuid.result])
  service_key_text  = join("-", ["auditlogmgmnt-key", random_uuid.uuid.result])
}

data "btp_subaccount_service_plan" "sp_auditlogmgmt__default" {
  subaccount_id = var.subaccount_id
  name          = local.service_plan_name
  offering_name = local.service_name
}


resource "btp_subaccount_service_instance" "si_auditlogmgmnt__default" {
  subaccount_id  = var.subaccount_id
  serviceplan_id = data.btp_subaccount_service_plan.sp_auditlogmgmt__default.id
  name           = local.service_name_text
}


resource "btp_subaccount_service_binding" "sk_auditlogmgmnt" {
  subaccount_id       = var.subaccount_id
  service_instance_id = resource.btp_subaccount_service_instance.si_auditlogmgmnt__default.id
  name                = local.service_key_text
}

resource "local_file" "output_service_keys" {
  count    = var.create_key_file ? 1 : 0
  content  = <<-EOT
      AUTH_URL     = ${jsondecode(btp_subaccount_service_binding.sk_auditlogmgmnt.credentials)["uaa"]["url"]}
      CLIENT_ID    = ${jsondecode(btp_subaccount_service_binding.sk_auditlogmgmnt.credentials)["uaa"]["clientid"]}
      CLIENT_SECRET= ${jsondecode(btp_subaccount_service_binding.sk_auditlogmgmnt.credentials)["uaa"]["clientsecret"]}
      
      EOT
  filename = "./servicebinding.txt"
}
