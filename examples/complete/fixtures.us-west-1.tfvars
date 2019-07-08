region = "us-west-1"

namespace = "eg"

stage = "test"

name = "es-test"

availability_zones = ["us-west-1b", "us-west-1c"]

instance_type = "t2.small.elasticsearch"

elasticsearch_version = "6.5"

instance_count = 1

zone_awareness_enabled = false

encrypt_at_rest_enabled = true

dedicated_master_enabled = false

kibana_subdomain_name = "kibana-es-test"

create_iam_service_linked_role = false

parent_zone_name = "testing.cloudposse.co"
