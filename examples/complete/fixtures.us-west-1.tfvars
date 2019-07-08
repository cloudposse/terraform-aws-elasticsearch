region = "us-west-1"

namespace = "eg"

stage = "test"

name = "es-test"

availability_zones = ["us-west-1b", "us-west-1c"]

instance_type = "t2.small.elasticsearch"

elasticsearch_version = "6.5"

instance_count = 2

zone_awareness_enabled = true

encrypt_at_rest_enabled = false

dedicated_master_enabled = false

kibana_subdomain_name = "kibana-es-test"

ebs_volume_size = 10

create_iam_service_linked_role = false

dns_zone_id = "Z3SO0TKDDQ0RGG"
