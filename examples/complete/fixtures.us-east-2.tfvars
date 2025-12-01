enabled = true

region = "us-east-2"

namespace = "eg"

stage = "test"

name = "es-test"

availability_zones = ["us-east-2a", "us-east-2b"]

instance_type = "t3.small.search"

engine_version = "OpenSearch_1.3"

instance_count = 2

zone_awareness_enabled = true

encrypt_at_rest_enabled = false

dedicated_master_enabled = false

elasticsearch_subdomain_name = ""

kibana_subdomain_name = ""

ebs_volume_size = 20

create_iam_service_linked_role = false

dns_zone_id = "Z3SO0TKDDQ0RGG"

kibana_hostname_enabled = true

domain_hostname_enabled = true
